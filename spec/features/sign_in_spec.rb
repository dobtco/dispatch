require 'spec_helper'

describe 'Signing in' do
  let!(:user) { create(:user, password: 'password') }

  it 'works properly' do
    visit root_path
    click_link t('sign_in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button t('sign_in')
    expect(page.body).to include t('devise.sessions.signed_in')
    click_link t('sign_out')
    expect(page.body).to include t('devise.sessions.signed_out')
  end
end
