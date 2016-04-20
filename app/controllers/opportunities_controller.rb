class OpportunitiesController < ApplicationController
  include OpportunitiesHelper

  before_action :set_opportunity

  def index
    @opportunities = Opportunity.posted.filter(params)
  end

  def pending
    authorize_staff

    @pending_approval_opportunities = Opportunity.not_approved.select do |opp|
      policy(opp).show?
    end

    @pending_publish_opportunities = Opportunity.not_published.approved.select do |opp|
      policy(opp).show?
    end
  end

  def new
    authorize_staff
    @opportunity = Opportunity.new
  end

  def create
    authorize_staff

    @opportunity = Opportunity.new(opportunity_params.merge(
      created_by_user: current_user
    ))

    if @opportunity.save
      redirect_to edit_opportunity_path(@opportunity, step: 'description')
    else
      render :new
    end
  end

  def edit
    unless params[:step].in?(edit_opportunity_steps)
      params[:step] = edit_opportunity_steps.first
    end

    authorize @opportunity, :edit?
  end

  def update
    authorize @opportunity, :edit?

    if @opportunity.update(opportunity_params)
      if next_step
        redirect_to edit_opportunity_path(@opportunity, step: next_step)
      else
        redirect_to opportunity_path(@opportunity)
      end
    else
      render :edit
    end
  end

  def destroy
    authorize @opportunity, :destroy?
    @opportunity.trash!
    redirect_to root_path
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

    if @opportunity.submission_page
      render "submission_adapters/#{@opportunity.submission_adapter.to_param}/submit"
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

  def opportunity_params
    params.require(:opportunity).permit(
      :title,
      :description,
      :department_id,
      :contact_name,
      :contact_email,
      :contact_phone,
      :submission_adapter_name,
      :publish_at,
      :submissions_open_at,
      :submissions_close_at,
      :enable_questions,
      :questions_open_at,
      :questions_close_at,
      category_ids: []
    ).tap do |h|
      # Allow all
      if (x = params[:opportunity][:submission_adapter_data]).present?
        h[:submission_adapter_data] = x
      end
    end
  end

  def next_step
    edit_opportunity_steps[edit_opportunity_steps.index(params[:step]) + 1]
  end
  end
