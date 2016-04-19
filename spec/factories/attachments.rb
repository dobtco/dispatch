# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  opportunity_id  :integer
#  upload          :string
#  content_type    :string
#  file_size_bytes :integer
#  has_thumbnail   :boolean          default(FALSE), not null
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_attachments_on_opportunity_id  (opportunity_id)
#

FactoryGirl.define do
  factory :attachment do
    opportunity

    upload do
      File.open(Rails.root.join('spec/fixtures/files/test.txt'))
    end
  end
end
