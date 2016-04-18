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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_opportunities_on_department_id  (department_id)
#

FactoryGirl.define do
  factory :opportunity do
    association :created_by_user, factory: :user
    department

    title 'Form Management Platform RFP'
    description %{
      The Office of Innovation & Technology (OIT) is seeking proposals to
      provide a form management platform for a 3-month pilot project involving
      the conversion of a number of public-facing PDF forms into responsive web
      forms. This pilot is part of a larger project where we will be working
      with multiple departments throughout the City organization.
    }.squish
  end
end
