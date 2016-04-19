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

FactoryGirl.define do
  factory :question do
    association :asked_by_user, factory: :user
    question_text 'Are you coding language agnostic?'

    trait :answered do
      association :answered_by_user, factory: :user
      answer_text 'Yes. coding language agnostic.'
      answered_at { Time.now }
    end
  end
end
