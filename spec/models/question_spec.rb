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

require 'spec_helper'

describe Question do
  subject { build(:question) }
  it { should be_valid }
end
