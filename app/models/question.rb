# == Schema Information
#
# Table name: questions
#
#  id                  :integer          not null, primary key
#  opportunity_id      :integer
#  asked_by_user_id    :integer
#  answered_by_user_id :integer
#  question_text       :text
#  answer_text         :text
#  answered_at         :datetime
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_questions_on_opportunity_id  (opportunity_id)
#

class Question < ActiveRecord::Base
  has_storage_unit

  belongs_to :opportunity
  belongs_to :asked_by_user, class_name: 'User'
  belongs_to :answered_by_user, class_name: 'User'

  scope :unanswered, -> { where('answered_at IS NULL') }
  scope :answered, -> { where('answered_at IS NOT NULL') }

  scope :unanswered_first, lambda {
    order('CASE WHEN answered_at IS NULL THEN 0 ELSE 1 END')
  }

  validates :asked_by_user, presence: true
  validates :question_text, presence: true

  def answered?
    answered_at.present?
  end
end
