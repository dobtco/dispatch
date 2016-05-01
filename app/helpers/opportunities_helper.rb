module OpportunitiesHelper
  def filtered?
    @opportunities.filterer.params[:text].present? ||
    @opportunities.filterer.params[:status] != 'open' ||
    @opportunities.filterer.params[:category_ids].present? ||
    @opportunities.filterer.params[:department_id].present?
  end

  def current_filter_params
    pick(@opportunities.filterer.params, *SavedSearch::PERMITTED_SEARCH_PARAMS)
  end

  def edit_opportunity_steps
    %w(
      description
      contact
      submissions
    )
  end

  def submission_adapter_edit_partial(adapter_class)
    "submission_adapters/#{adapter_class.to_param}/edit"
  end

  def opportunity_timeline_events
    pick(
      @opportunity,
      :publish_at,
      :submissions_open_at,
      :submissions_close_at,
      :questions_open_at,
      :questions_close_at
    ).select { |_, v| v.present? }.
      sort_by(&:last)
  end
end
