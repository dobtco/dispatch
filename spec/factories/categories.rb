# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :category do
    sequence(:name) do |i|
      names = [
        'Business Intelligence & Analytics',
        'Consulting',
        'Creative Services',
        'CRM',
        'Data Management',
        'Database',
        'General',
        'Mobile Apps',
        'Process Improvement',
        'Support',
        'Web Apps',
        'Web Design'
      ]

      names[i % names.length]
    end
  end
end
