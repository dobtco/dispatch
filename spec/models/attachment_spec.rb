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

require 'spec_helper'

describe Attachment do
  subject { build(:attachment) }
  it { should be_valid }

  describe '#text_content' do
    its(:text_content) { should include 'hi!' }

    context 'when attachment is a docx' do
      subject { build(:attachment, :docx) }
      its(:text_content) { should include 'Hey there, this is a word doc!' }
    end

    context 'when attachment is an empty file' do
      subject { build(:attachment, :empty) }
      its(:text_content) { should be_blank }
    end
  end
end
