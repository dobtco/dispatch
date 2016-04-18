# == Schema Information
#
# Table name: opportunities
#
#  id                     :integer          not null, primary key
#  created_by_user_id     :integer
#  title                  :string
#  description            :text
#  department_id          :integer
#  contact_name           :string
#  contact_email          :string
#  contact_phone          :string
#  submission_method      :string
#  submission_method_data :text
#  publish_at             :datetime
#  submissions_open_at    :datetime
#  submissions_close_at   :datetime
#  enable_questions       :boolean          default(FALSE), not null
#  questions_open_at      :datetime
#  questions_close_at     :datetime
#  approved_at            :datetime
#  approved_by_user_id    :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_opportunities_on_department_id  (department_id)
#

class Opportunity < ActiveRecord::Base
  belongs_to :created_by_user, class_name: 'User'
  belongs_to :approved_by_user, class_name: 'User'
  belongs_to :department

  scope :not_approved, -> {
    where('approved_at IS NULL')
  }

  scope :approved, -> {
    where('approved_at IS NOT NULL')
  }
end
