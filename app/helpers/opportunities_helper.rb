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
          publish_at: @opportunity.publish_at)
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

  def all_submission_adapters
    [
      SubmissionAdapters::None,
      SubmissionAdapters::Screendoor,
      SubmissionAdapters::Email
    ]
  end

  def submission_adapter_edit_partial(adapter_class)
    "submission_adapters/#{adapter_class.to_param}/edit"
  end
end
