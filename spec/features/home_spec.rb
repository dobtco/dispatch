require 'spec_helper'

describe 'Home' do
  let!(:visible_opportunity) { create(:opportunity, :published, :approved) }
  let!(:not_visible_opportunity) { create(:opportunity, :published) }

  it 'shows recently posted opportunities' do
    visit root_path

    expect(page).to have_selector(
      %{[href="#{opportunity_path(visible_opportunity)}"]}
    )

    expect(page).to_not have_selector(
      %{[href="#{opportunity_path(not_visible_opportunity)}"]}
    )
  end
end
