# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  permission_level       :integer          default(0), not null
#  business_name          :string
#  business_data          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'spec_helper'

describe User do
  subject { build(:user) }
  it { should be_valid }

  describe '#permission_level_is_at_least?' do
    it 'functions properly' do
      expect(subject.permission_level_is_at_least?('user')).to eq true
      expect(subject.permission_level_is_at_least?('approver')).to eq false
    end
  end

  describe 'automatic staff permissions' do
    context 'when user email matches a staff domain' do
      before do
        subject.email = 'foo@beacon.gov'
        subject.save
      end

      it { should be_staff }
    end

    context 'when user email does not match a staff domain' do
      before do
        subject.email = 'foo@a-beacon.gov'
        subject.save
      end

      it { should_not be_staff }
    end
  end
end
