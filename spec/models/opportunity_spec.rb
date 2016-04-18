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

require 'spec_helper'

describe Opportunity do
  subject { build(:opportunity) }
  it { should be_valid }

  describe '.published' do
    context 'when publish_at is in the past' do
      before { subject.update(publish_at: Time.now - 1.day) }

      it 'is published' do
        expect(described_class.published).to eq [subject]
      end
    end

    context 'when publish_at is in the future' do
      before { subject.update(publish_at: Time.now + 1.day) }

      it 'is not published' do
        expect(described_class.published).to eq []
      end
    end
  end

  describe '.order_by_recently_posted' do
    let!(:approved_recently) do
      create(:opportunity, :published, approved_at: Time.now - 1.minute)
    end

    let!(:published_now) do
      create(:opportunity, publish_at: Time.now, approved_at: Time.now - 1.hour)
    end

    it 'orders properly' do
      expect(described_class.order_by_recently_posted).to eq(
        [published_now, approved_recently]
      )
    end
  end

  describe '#posted_at' do
    before do
      subject.update(publish_at: Time.now, approved_at: Time.now - 1.hour)
    end

    its(:posted_at) { should eq subject.publish_at }
  end
end
