class QuestionsController < ApplicationController
  before_action :set_opportunity
  before_action :set_question

  def create
    authorize @opportunity, :ask_question?
    @opportunity.questions.create(ask_question_params)
    redirect_to :back
  end

  def update
    authorize @opportunity, :answer_questions?
    @question.update(answer_question_params)
    redirect_to :back
  end

  def destroy
    authorize @opportunity, :answer_questions?
    @question.destroy
    redirect_to :back
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:opportunity_id])
  end

  def set_question
    if params[:id]
      @question = @opportunity.questions.find(params[:id])
    end
  end

  def ask_question_params
    params.require(:question).permit(
      :question_text
    ).merge(
      asked_by_user: current_user
    )
  end

  def answer_question_params
    params.require(:question).permit(
      :answer_text
    ).merge(
      answered_by_user: current_user
    ).tap do |h|
      h[:answered_at] = if h[:answer_text].present?
                          @question.answered_at || Time.now
                        else
                          nil
                        end
    end
  end
end
