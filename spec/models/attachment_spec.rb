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
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_attachments_on_opportunity_id  (opportunity_id)
#

require 'spec_helper'

describe Attachment do
  subject { build(:attachment) }
  it { should be_valid }
end
