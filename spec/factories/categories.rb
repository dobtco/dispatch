# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  group_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :category do
    name 'Custom Computer Programming Services'
    group_name 'Computer Systems Design and Related Services'
  end
end
