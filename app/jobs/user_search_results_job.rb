# Run on an interval. Will look for responses that match *any* of a
# user's saved searches.
class UserSearchResultsJob < ApplicationJob
  def perform(user)
    opp_ids = user.
                saved_searches.
                map { |saved_search| saved_search_opp_ids(saved_search) }.
                flatten.
                uniq

    notify_opp_ids = opp_ids - already_notified_of_opp_ids(user)
    return unless notify_opp_ids.present?
    Mailer.search_results(user, notify_opp_ids).deliver_later
    create_audit(user, notify_opp_ids)
  end

  private

  def create_audit(user, notify_opp_ids)
    user.audits.create(
      event: audit_event,
      data: { 'opportunity_ids' => notify_opp_ids }
    )
  end

  def already_notified_of_opp_ids(user)
    user.
      audits.
      where(event: audit_event).
      pluck(:data).
      map { |data| Array(data['opportunity_ids']) }.
      flatten.
      uniq
  end

  def saved_search_opp_ids(saved_search)
    Opportunity.
      posted.
      filter(saved_search.search_params, skip_pagination: true).
      pluck(:id)
  end

  def audit_event
    'user_search_results.notify'
  end
end
