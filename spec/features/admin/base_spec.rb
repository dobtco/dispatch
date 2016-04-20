require 'spec_helper'

describe 'Admin' do
  context 'when user is an admin' do
    let!(:user) { create(:user, :admin) }
    before { login_as user }

    it 'renders properly' do
      visit admin_root_path
      expect(page).to have_selector 'h1', text: 'Users'
    end

    it 'visits each page' do
      visit admin_root_path

      links = all('.sidebar__link')[1..-1].map(&:text)

      links.each do |link|
        find('.sidebar__link', text: link).click
      end
    end

    context 'with deleted resources' do
      let!(:deleted_opportunity) { create(:opportunity, deleted_at: Time.now) }

      it 'shows resources' do
        visit admin_opportunities_path
        find('tr', text: deleted_opportunity.title).click_link 'Edit'
        expect(page).to have_text deleted_opportunity.title
      end
    end

    context 'with non soft-deleteable resources' do
      it 'shows resources' do
        visit admin_user_path(user)
        expect(page).to have_text user.name
      end
    end
  end

  context 'when user is not an admin' do
    let!(:user) { create(:user) }
    before { login_as user }

    it 'denies access' do
      visit admin_root_path
      expect(page).to have_text 'not authorized'
    end
  end
end
