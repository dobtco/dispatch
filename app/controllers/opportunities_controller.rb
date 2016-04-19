class OpportunitiesController < ApplicationController
  before_action :set_opportunity

  def index
    @opportunities = Opportunity.posted.filter(params)
  end

  def show
    authorize @opportunity, :show?
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
