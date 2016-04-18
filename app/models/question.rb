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
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_questions_on_opportunity_id  (opportunity_id)
#

class Question < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :asked_by_user, class_name: 'User'
  belongs_to :answered_by_user, class_name: 'User'
end
