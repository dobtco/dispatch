module OpportunityHelper
  def is_filtered?
    @opportunities.filterer.params[:text].present? ||
    @opportunities.filterer.params[:status] != 'open' ||
    @opportunities.filterer.params[:category_id].present?
  end

  def opportunity_status_text
    if @opportunity.approved?
      if @opportunity.published?
        t('opportunity_status.posted')
      else
        t('opportunity_status.waiting_for_publish_date', publish_at: @opportunity.publish_at)
      end
    else
      t('opportunity_status.not_approved')
    end
  end
end
