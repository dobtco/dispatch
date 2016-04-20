require 'spec_helper'

describe 'Users' do
  let!(:user) { create(:user) }

  describe 'Signing up' do
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

  describe 'Editing your account' do
    it 'functions properly' do
      login_as user
      visit edit_user_registration_path
      expect(page).to_not have_field :user_password
      fill_in :user_name, with: 'newname'
      find('#edit_user button').click
      expect(user.reload.name).to eq 'newname'
    end
  end

  describe 'Changing your password' do
    it 'functions properly' do
      login_as user
      visit edit_user_registration_path(type: 'password')
      expect(page).to_not have_field :user_name

      # Error without current password
      fill_in :user_password, with: 'newpassword'
      fill_in :user_password_confirmation, with: 'newpassword'
      find('#edit_user button').click
      expect(page).to_not have_text t('devise.registrations.updated')

      fill_in :user_password, with: 'newpassword'
      fill_in :user_password_confirmation, with: 'newpassword'
      fill_in :user_current_password, with: 'password'
      find('#edit_user button').click
      expect(page).to have_text t('devise.registrations.updated')
    end
  end
end
