# == Schema Information
#
# Table name: opportunities
#
#  id                                :integer          not null, primary key
#  created_by_user_id                :integer
#  title                             :string
#  description                       :text
#  department_id                     :integer
#  contact_name                      :string
#  contact_email                     :string
#  contact_phone                     :string
#  submission_adapter_name           :string
#  submission_adapter_data           :text
#  publish_at                        :datetime
#  submissions_open_at               :datetime
#  submissions_close_at              :datetime
#  submission_deadline_reminder_sent :boolean          default(FALSE), not null
#  enable_questions                  :boolean          default(FALSE), not null
#  questions_open_at                 :datetime
#  questions_close_at                :datetime
#  question_deadline_reminder_sent   :boolean          default(FALSE), not null
#  submitted_at                      :datetime
#  approved_at                       :datetime
#  approved_by_user_id               :integer
#  deleted_at                        :datetime
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_opportunities_on_department_id  (department_id)
#

FactoryGirl.define do
  factory :opportunity do
    association :created_by_user, factory: :user
    department

    sequence(:title) do |i|
      names = [
        'Seeking creative research on Philadelphians’ traffic knowledge' \
        ' and behavior',
        'Seeking unconventional and creative marketing + outreach',
        'Seeking proposals to improve/replace the Big ideas PHL website',
        'Form Management Platform RFP',
        'Develop a publication to market the City of Philadelphia as a ' \
        'premier business location'
      ]

      names[i % names.length]
    end

    description <<-DESC.strip_heredoc
      The Office of Innovation & Technology (OIT) is seeking proposals to
      provide a form management platform for a 3-month pilot project involving
      the conversion of a number of public-facing PDF forms into responsive web
      forms. This pilot is part of a larger project where we will be working
      with multiple departments throughout the City organization.

      A Request For Proposals

      From: The City of Philadelphia’s Office of New Urban Mechanics

      For: Analytical, design and, likely, web services and the creation of two
      specific deliverables

      Crafting a Toolkit to Enable Pilots in City Procurement: Lessons Learned
      from Philadelphia’s FastFWD Initiative

      The City of Philadelphia has supported a variety of efforts to bring
      innovation to our work and to concurrently lend support to Philadelphia’s
      vital startup economy.

      FastFWD, an initiative co-led by the Philadelphia Mayor’s Office of New
      Urban Mechanics, is our most comprehensive and integrated effort to date.
      It has included an incubator style curriculum for two cohorts of promising
      entrepreneurs that are not yet mature companies (hence, startups). They
      received mentoring, training, and insight into how government works with
      a focus on Public Safety and Community Stability (Police, Fire,
      Corrections Departments etc.) . Funding was competitively offered to a
      short list of the participating firms for pilots with select City
      agencies. At this time, the selected firms from the first cohort have
      implemented their pilots which were to last approximately one year, and
      the firms from the second cohort have just pitched/applied to be selected
      for pilot funding.
    DESC

    trait :published do
      publish_at { Time.now - 1.day }
    end

    trait :approved do
      association :approved_by_user, factory: :user
      approved_at { Time.now }
    end
  end
end
