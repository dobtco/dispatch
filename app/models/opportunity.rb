# == Schema Information
#
# Table name: opportunities
#
#  id                      :integer          not null, primary key
#  created_by_user_id      :integer
#  title                   :string
#  description             :text
#  department_id           :integer
#  contact_name            :string
#  contact_email           :string
#  contact_phone           :string
#  submission_adapter_name :string
#  submission_adapter_data :text
#  publish_at              :datetime
#  submissions_open_at     :datetime
#  submissions_close_at    :datetime
#  enable_questions        :boolean          default(FALSE), not null
#  questions_open_at       :datetime
#  questions_close_at      :datetime
#  submitted_at            :datetime
#  approved_at             :datetime
#  approved_by_user_id     :integer
#  deleted_at              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_opportunities_on_department_id  (department_id)
#

class Opportunity < ActiveRecord::Base
  include PgSearch

  has_storage_unit

  # Currently using this to manage permissions. Eventually we could switch
  # to a 1-many
  belongs_to :created_by_user, class_name: 'User'

  belongs_to :approved_by_user, class_name: 'User'
  belongs_to :department

  has_and_belongs_to_many :categories
  has_many :questions, dependent: :destroy
  has_many :attachments, dependent: :destroy

  serialize :submission_adapter_data, Hash

  scope :not_approved, -> { where('approved_at IS NULL') }
  scope :approved, -> { where('approved_at IS NOT NULL') }

  scope :published, -> do
    where('publish_at IS NULL OR publish_at < ?', Time.now)
  end

  scope :not_published, -> do
    where('publish_at IS NOT NULL AND publish_at > ?', Time.now)
  end

  scope :posted, -> { approved.published }

  scope :not_posted, -> do
    where('(publish_at IS NOT NULL AND publish_at > ?) || approved_at IS NULL')
  end

  scope :order_by_recently_posted, -> do
    order('GREATEST(publish_at, approved_at) DESC')
  end

  scope :submissions_open, -> do
    where('submissions_close_at IS NULL OR submissions_close_at > ?', Time.now)
  end

  scope :submissions_closed, -> do
    where(
      'submissions_close_at IS NOT NULL AND submissions_close_at < ?',
      Time.now
    )
  end

  pg_search_scope(
    :full_text,
    against: [
      :title,
      :description,
      :contact_name,
      :contact_email,
      :contact_phone
    ],
    associated_against: {
      questions: [:question_text, :answer_text],
      attachments: [:upload],
      department: [:name]
    },
    using: {
      tsearch: {
        prefix: true
      }
    }
  )

  def self.with_any_category(category_ids)
    where(
      %(
        (SELECT categories_opportunities.category_id
        FROM categories_opportunities
        WHERE categories_opportunities.opportunity_id = opportunities.id
        AND categories_opportunities.category_id IN (?)
        LIMIT 1) IS NOT NULL
      ).squish,
      category_ids
    )
  end

  validates :title, presence: true
  validates :created_by_user, presence: true

  delegate :submission_page,
           :view_proposals_url,
           :view_proposals_instructions,
           :submit_proposals_url,
           :submit_proposals_instructions,
           :submittable?,
           to: :submission_adapter

  before_create :set_default_submission_adapter_name,
                :set_default_contact_info

  def posted?
    approved? && published?
  end

  def approved?
    approved_at.present?
  end

  def approve!
    update approved_at: Time.now
  end

  def unapprove!
    update approved_at: nil
  end

  def published?
    !publish_at ||
    publish_at < Time.now
  end

  def posted_at
    [
      publish_at,
      approved_at
    ].compact.max
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def submission_adapter
    if submission_adapter_name.present?
      "SubmissionAdapters::#{submission_adapter_name}".constantize.new(self)
    else
      default_submission_adapter
    end
  rescue
    default_submission_adapter
  end

  def open_for_submissions?
    (!submissions_open_at || submissions_open_at < Time.now) &&
    (!submissions_close_at || submissions_close_at > Time.now)
  end

  def open_for_questions?
    enable_questions? &&
    (!questions_open_at || questions_open_at < Time.now) &&
    (!questions_close_at || questions_close_at > Time.now)
  end

  private

  def default_submission_adapter
    SubmissionAdapters::None.new(self)
  end

  def set_default_submission_adapter_name
    self.submission_adapter_name ||= default_submission_adapter.
                                      class.
                                      to_adapter_name
  end

  def set_default_contact_info
    self.contact_name ||= created_by_user.name
    self.contact_email ||= created_by_user.email
  end
end
