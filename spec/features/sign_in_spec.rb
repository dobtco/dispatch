require 'spec_helper'

describe 'Signing in' do
  let!(:user) { create(:user, password: 'password') }

  it 'works properly' do
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page.body).to include t('devise.sessions.signed_in')
    click_link 'Sign out'
    expect(page.body).to include t('devise.sessions.signed_out')
  end
end
