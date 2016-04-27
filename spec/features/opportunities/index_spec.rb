require 'spec_helper'

describe 'Opportunities - Index' do
  let!(:vendor) { create(:user) }
  let!(:opportunity) do
    create(:opportunity, :approved)
  end

  it 'shows the list of opportunities' do
    visit opportunities_path
    expect(page).to have_link opportunity.title
  end

  it 'filters properly' do
    visit opportunities_path
    expect(page).to have_text opportunity.title
    fill_in :opportunity_filters_text, with: 'nothingmatchesthis'
    find('.opportunity_filters button').click
    expect(page).to_not have_text opportunity.title
    expect(page).to have_link t('save_search'), href: new_user_session_path

    # Clear filters
    click_link t('clear')
    expect(page).to have_text opportunity.title
  end

  context 'when signed in' do
    before { login_as vendor }

    it 'saved a search' do
      visit opportunities_path
      fill_in :opportunity_filters_text, with: 'nothingmatchesthis'
      find('.opportunity_filters button').click
      expect { click_link t('save_search') }.
        to change { vendor.saved_searches.count }.by(1)
    end
  end
end
