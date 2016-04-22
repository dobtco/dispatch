# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :department do
    sequence(:name) do |i|
      names = [
        'Office of Management and Budget',
        'Office of Technology and Innovation',
        "Mayor's Office"
      ]

      names[i % names.length]
    end
  end
end
