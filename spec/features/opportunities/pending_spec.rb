require 'spec_helper'

describe 'Opportunities - Pending' do
  let!(:user) { create(:user) }

  let!(:pending_publish_opportunity) do
    create(:opportunity, :approved, publish_at: Time.now + 1.hour)
  end

  let!(:pending_approval_opportunity) { create(:opportunity) }
  let(:published_opportunity) { create(:opportunity, :approved) }

  before { login_as user }

  context 'as a vendor' do
    it 'denies access' do
      visit pending_opportunities_path
      expect(current_path).to eq root_path
    end
  end

  context 'as a staff member' do
    before do
      user.staff!
      pending_publish_opportunity.update(created_by_user: user)
    end

    it 'denies access' do
      visit pending_opportunities_path
      expect(current_path).to eq root_path
    end
  end

  context 'as an approver' do
    before { user.approver! }

    it 'renders all pending opportunities' do
      visit pending_opportunities_path
      expect(page).to have_text pending_publish_opportunity.title
      expect(page).to have_text pending_approval_opportunity.title
      expect(page).to_not have_text published_opportunity.title
    end
  end
end
