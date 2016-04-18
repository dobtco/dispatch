require 'spec_helper'

describe 'Admin' do
  context 'when user is an admin' do
    let!(:user) { create(:user, :admin) }

    it 'renders properly' do
      login_as user
      visit admin_root_path
      expect(page).to have_selector 'h1', text: 'Users'
    end
  end

  context 'when user is not an admin' do
    let!(:user) { create(:user) }

    it 'denies access' do
      login_as user
      visit admin_root_path
      expect(page).to have_text 'not authorized'
    end
  end
end
