module OpportunitiesHelper
  def filtered?
    @opportunities.filterer.params[:text].present? ||
    @opportunities.filterer.params[:status] != 'open' ||
    @opportunities.filterer.params[:category_ids].present?
  end

  def current_filter_params
    pick(@opportunities.filterer.params, *SavedSearch::PERMITTED_SEARCH_PARAMS)
  end

  def opportunity_status_text
    if @opportunity.approved?
      if @opportunity.published?
        t('opportunity_status.posted')
      else
        t('opportunity_status.waiting_for_publish_date',
          publish_at: long_timestamp(@opportunity.publish_at)).html_safe
      end
    elsif @opportunity.submitted_for_approval?
      t('opportunity_status.pending_approval')
    else
      t('opportunity_status.not_approved')
    end
  end

  def edit_opportunity_steps
    %w(
      title
      description
      questions
      submissions
    )
  end

  def submission_adapter_edit_partial(adapter_class)
    "submission_adapters/#{adapter_class.to_param}/edit"
  end

  def pending_opportunities_page_title
    if policy(:opportunity).approve?
      t('approve_opportunities')
    else
      t('pending_opportunities')
    end
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
      sort.
      reverse
  end
end
