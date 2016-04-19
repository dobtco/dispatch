class OpportunitiesController < ApplicationController
  before_action :set_opportunity

  def index
    @opportunities = Opportunity.posted.filter(params)
  end

  def show
    authorize @opportunity, :show?
  end

  def approve
    authorize @opportunity, :approve?

    if @opportunity.approved?
      @opportunity.unapprove!
    else
      @opportunity.approve!
    end

    redirect_to :back
  end

  def subscribe
    authorize @opportunity, :subscribe?

    if current_user.opportunities.include?(@opportunity)
      current_user.opportunities.destroy(@opportunity)
    else
      current_user.opportunities << @opportunity
    end

    redirect_to :back
  end

  def submit
    authorize @opportunity, :submit?

    if @opportunity.submission_adapter.submission_page
      render "submission_adapters/#{@opportunity.submission_adapter.to_param}"
    else
      redirect_to opportunity_path
    end
  end

  private

  def set_opportunity
    if params[:id]
      @opportunity = Opportunity.find(params[:id])

      # Verify slug is correct
      if @opportunity && (params[:id] != @opportunity.to_param)
        redirect_to url_for(id: @opportunity.to_param),
                    status: :moved_permanently
      end
    end
  end
end
