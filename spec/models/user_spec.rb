# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  admin_roles            :text             default([]), is an Array
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

  describe 'Admin roles' do
    it { should_not be_staff }
    it { should_not be_approver }
    it { should_not be_admin }

    context 'with admin roles' do
      before do
        subject.admin_roles = [
          described_class.admin_roles[:staff],
          described_class.admin_roles[:approver]
        ]
      end

      it { should be_staff }
      it { should be_approver }
      it { should_not be_admin }
    end
  end
end
