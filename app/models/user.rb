# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  permission_level       :integer          default(0), not null
#  business_name          :string
#  business_data          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Used for "Subscribe to this opportunity"
  has_and_belongs_to_many :opportunities

  has_many :saved_searches, dependent: :destroy
  has_many :audits, dependent: :destroy

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  enum permission_level: [:user, :staff, :approver, :admin]

  scope :approvers_and_admins, -> do
    where(
      # This syntax should be better in Rails 5
      permission_level: User.permission_levels.slice(:approver, :admin).values
    )
  end

  validates :name, presence: true

  serialize :business_data, Hash

  before_create :set_staff_if_email_matches_staff_domain

  attr_accessor :subscribe_to_category_ids
  after_create :create_saved_search_from_category_ids

  # https://github.com/plataformatec/devise/#activejob-integration
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def permission_level_is_at_least?(x)
    User.permission_levels[permission_level] >= User.permission_levels[x]
  end

  private

  def set_staff_if_email_matches_staff_domain
    if email_domain.in?(Configuration.staff_domains)
      self.permission_level = 'staff'
    end
  end

  def email_domain
    email.split('@').last
  end

  def create_saved_search_from_category_ids
    sanitized_ids = Array(subscribe_to_category_ids).
                      select { |category_id| category_id.to_s =~ /\A[0-9]+\Z/ }.
                      map(&:to_i).
                      compact

    if sanitized_ids.present?
      saved_searches.create(search_params: { 'category_ids' => sanitized_ids })
    end
  end
end
