require 'spec_helper'

describe 'Opportunity creation' do
  include OpportunitiesHelper

  let!(:staff) { create(:user, :staff) }
  let!(:opportunity) { create(:opportunity, created_by_user: staff) }
  before { login_as staff }

  it 'renders each step sequentially' do
    visit new_opportunity_path
    fill_in :opportunity_title, with: 'newopp'
    find('#new_opportunity button').click

    edit_opportunity_steps.each do |x|
      click_link t("edit_opportunity_steps.#{x}.title")
    end

    find('.edit_opportunity button').click
    expect(page).to have_text 'newopp'
  end

  it 'allows for uploading and destroying attachments', js: true do
    visit edit_opportunity_path(opportunity, step: 'description')
    show_hidden_file_inputs
    attach_file :attachment_upload,
                Rails.root.join('spec/fixtures/files/test.txt')
    wait_for_ajax
    expect(page).to have_text 'test.txt'
    find('.js-remove-attachment').click
    expect(page).to_not have_text 'test.txt'
  end
end
