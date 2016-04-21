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

  describe '#open_for_submissions?' do
    it { should be_open_for_submissions }

    context 'when close date is past' do
      before { subject.submissions_close_at = Time.now - 1.minute }
      it { should_not be_open_for_submissions }
    end
  end

  describe '#posted_at' do
    before do
      subject.update(publish_at: Time.now, approved_at: Time.now - 1.hour)
    end

    its(:posted_at) { should eq subject.publish_at }
  end

  describe '#submission_adapter_name' do
    context 'by default' do
      before { subject.save }
      its(:submission_adapter_name) { should eq 'None' }
    end
  end

  describe '#submission_adapter' do
    context 'by default' do
      its(:submission_adapter) { should be_a(SubmissionAdapters::None) }
    end

    context 'when invalid' do
      before { subject.submission_adapter_name = 'foobar' }
      its(:submission_adapter) { should be_a(SubmissionAdapters::None) }
    end

    context 'when valid' do
      before { subject.submission_adapter_name = 'Base' }
      its(:submission_adapter) { should be_a(SubmissionAdapters::Base) }
    end
  end
end
