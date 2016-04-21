require 'spec_helper'

describe 'Opportunities - Show' do
  let!(:vendor) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:opportunity) do
    create(:opportunity, :approved, created_by_user: admin)
  end

  it 'shows an opportunity' do
    visit opportunity_path(opportunity)
    expect(page).to have_text opportunity.title
  end

  context 'when the slug is incorrect' do
    it 'redirects to the correct slug' do
      visit opportunity_path(id: opportunity.to_param + 'asdf')
      expect(current_path).to eq opportunity_path(opportunity)
    end
  end

  it 'can subscribe and unsubscribe to the opportunity' do
    login_as vendor
    visit opportunity_path(opportunity)
    click_link t('subscribe')
    click_link t('subscribed')
    expect(page).to have_link t('subscribe')
  end

  context 'when opportunity is not posted' do
    before { opportunity.update(publish_at: Time.now + 1.day) }

    it 'denies access to public' do
      visit opportunity_path(opportunity)
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'Screendoor submissions' do
    before { opportunity.update(submission_adapter_name: 'Screendoor') }

    it 'renders the submission page' do
      visit opportunity_path(opportunity)
      click_link t('submit_proposal')
      expect(current_path).to eq submit_opportunity_path(opportunity)
    end
  end

  context 'Email submissions' do
    before do
      opportunity.update(
        submission_adapter_name: 'Email',
        submission_adapter_data: {
          'name' => 'FoobarBaz'
        }
      )
    end

    it 'renders the email address for submission' do
      visit opportunity_path(opportunity)
      expect(page).to have_link 'FoobarBaz'
    end
  end

  context 'when logged in as an admin' do
    before { login_as admin }

    it 'can approve and un-approve the opportunity' do
      visit opportunity_path(opportunity)
      click_link t('unapprove')
      click_link t('approve')
      expect(page).to have_link t('unapprove')
    end

    it 'can destroy the opportunity' do
      visit opportunity_path(opportunity)
      click_link t('destroy')
      expect(opportunity.reload).to be_trashed
    end
  end
end
