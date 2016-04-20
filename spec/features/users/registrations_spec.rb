require 'spec_helper'

describe 'Users - Registration' do
  context 'as a vendor' do
    it 'functions properly' do
      visit new_user_registration_path

      # With errors
      fill_in :user_business_name, with: 'Foobar Co'
      fill_in :user_name, with: 'Joe Shmo'
      fill_in :user_email, with: 'joe@foobar.biz'
      fill_in :user_password, with: 'pass'
      find('#new_user button').click
      expect(page).to have_text 'too short'

      # Fix errors
      fill_in :user_password, with: 'password'
      find('#new_user button').click
      expect(page).to have_text(
        t('devise.registrations.signed_up_but_unconfirmed')
      )
    end
  end

  context 'as city staff' do
    it 'functions properly' do
      visit new_user_registration_path(type: 'staff')

      expect(page).to_not have_field :user_business_name

      fill_in :user_name, with: 'Joe Shmo'
      fill_in :user_email, with: 'joe@foobar.biz'
      fill_in :user_password, with: 'password'
      find('#new_user button').click
      expect(page).to have_text(
        t('devise.registrations.signed_up_but_unconfirmed')
      )
    end
  end
end
