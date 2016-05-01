require 'spec_helper'

describe 'Users' do
  let!(:category) { create(:category) }
  let!(:user) { create(:user) }

  def created_user
    User.order('id').last
  end

  describe 'Signing up' do
    context 'as a vendor' do
      it 'functions properly' do
        visit new_user_registration_path

        # With errors
        fill_in :user_business_name, with: 'Foobar Co'
        fill_in :user_name, with: 'Joe Shmo'
        fill_in :user_email, with: 'joe@foobar.biz'
        fill_in :user_password, with: 'pass'
        select category.name, from: :user_subscribe_to_category_ids
        find('#new_user button').click
        expect(page).to have_text 'too short'

        # Fix errors
        fill_in :user_password, with: 'password'
        expect { find('#new_user button').click }.
          to change { User.count }.by(1)

        # Creates a saved search
        expect(created_user.saved_searches.first.search_params).to eq(
          'category_ids' => [category.id]
        )
      end

      context 'without choosing categories' do
        it 'does not create a saved search' do
          visit new_user_registration_path

          fill_in :user_business_name, with: 'Foobar Co'
          fill_in :user_name, with: 'Joe Shmo'
          fill_in :user_email, with: 'joe@foobar.biz'
          fill_in :user_password, with: 'password'
          fill_in :user_password, with: 'password'

          expect { find('#new_user button').click }.
            to change { User.count }.by(1)

          # Creates a saved search
          expect(created_user.saved_searches.count).to eq 0
        end
      end
    end

    context 'as city staff' do
      it 'functions properly' do
        visit new_user_registration_path(type: 'staff')

        expect(page).to_not have_field :user_business_name

        fill_in :user_name, with: 'Joe Shmo'
        fill_in :user_email, with: 'joe@dispatch.gov'
        fill_in :user_password, with: 'password'
        expect { find('#new_user button').click }.
          to change { User.count }.by(1)
      end

      it 'errors on invalid domain' do
        visit new_user_registration_path(type: 'staff')

        expect(page).to_not have_field :user_business_name

        fill_in :user_name, with: 'Joe Shmo'
        fill_in :user_email, with: 'joe@foobar.biz'
        fill_in :user_password, with: 'password'
        expect { find('#new_user button').click }.to_not change { User.count }
        expect(page).to have_text(
          t('activerecord.errors.messages.invalid_staff_domain')
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

    context 'with a saved search' do
      let!(:saved_search) { create(:saved_search, user: user) }

      it 'allows for deleting the search' do
        login_as user
        visit edit_user_registration_path
        expect { click_link t('unsubscribe') }.
          to change { user.saved_searches.count }.by(-1)
      end
    end

    context 'with a created opportunity' do
      let!(:opportunity) { create(:opportunity, created_by_user: user) }

      it 'shows the opportunity' do
        login_as user
        visit edit_user_registration_path
        expect(page).to have_link opportunity.title
      end
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
      expect(page.body).to include t('devise.registrations.updated')
    end
  end
end
