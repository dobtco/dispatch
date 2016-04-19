class AttachmentsController < ApplicationController
  before_action :set_opportunity
  before_action { authorize @opportunity, :edit? }
  before_action :set_attachment

  def create
    @attachment = @opportunity.attachments.build(upload: params[:file])

    if @attachment.save
      render json: {
        ok: true,
        html: render_to_string(
          partial: 'opportunities/edit_attachment',
          locals: { attachment: @attachment }
        )
      }
    else
      render json: {
        error: @attachments.errors.messages.join('. ')
      }, status: :bad_request
    end
  end

  def destroy
    @attachment.destroy
    render json: { ok: true }
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:opportunity_id])
  end

  def set_attachment
    if params[:id]
      @attachment = @opportunity.attachments.find(params[:id])
    end
  end
end
