require 'spec_helper'

describe 'Signing in' do
  let!(:user) { create(:user, password: 'password') }

  it 'works properly' do
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_text 'Signed in successfully'
    click_link 'Sign out'
    expect(page).to have_text 'Signed out successfully'
  end
end
