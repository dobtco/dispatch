require 'spec_helper'

describe UserSearchResultsJob do
  let!(:user) { create(:user) }
  let!(:opportunity) { create(:opportunity, :approved) }
  let!(:not_approved_opportunity) { create(:opportunity) }
  let!(:saved_search) { create(:saved_search, user: user) }
  let!(:saved_search_two) { create(:saved_search, user: user) }
  let!(:saved_search_not_matching) do
    create(
      :saved_search,
      user: user,
      search_params: { 'text' => 'lolnomatch' }
    )
  end

  it 'notifies the user *once* of approved opportunities' do
    expect_any_instance_of(Mailer).to receive(:search_results).
      with(user, [opportunity.id]).and_call_original

    2.times do
      described_class.perform_now(user)
    end
  end
end
