class QuestionsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_opportunity
  before_action :set_question

  def create
    authorize @opportunity, :ask_question?
    @question = @opportunity.questions.build(ask_question_params)

    if @question.save && !asking_about_own_opportunity?
      Mailer.question_asked(
        @opportunity.created_by_user,
        @question
      ).deliver_later
    end

    redirect_to opportunity_path(@opportunity) + "##{dom_id(@question)}"
  end

  def update
    authorize @opportunity, :answer_questions?
    @question.update(answer_question_params)

    if @question.answered? && !answering_own_question?
      Mailer.question_answered(
        @question.asked_by_user,
        @question
      ).deliver_later
    end

    redirect_to opportunity_path(@opportunity) + "##{dom_id(@question)}"
  end

  def destroy
    authorize @opportunity, :answer_questions?
    @question.trash!
    redirect_to :back, info: t('question_destroyed')
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
                        end
    end
  end

  def asking_about_own_opportunity?
    @question.asked_by_user == @opportunity.created_by_user
  end

  def answering_own_question?
    @question.asked_by_user == current_user
  end
end
