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
#  text_content    :text
#
# Indexes
#
#  index_attachments_on_opportunity_id  (opportunity_id)
#

class Attachment < ActiveRecord::Base
  belongs_to :opportunity

  has_storage_unit

  mount_uploader :upload, AttachmentUploader
  validates :upload, presence: true
end
