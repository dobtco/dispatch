class MailerPreview < ActionMailer::Preview
  def search_results
    Mailer.search_results(
      User.first || FactoryGirl.create(:user),
      Opportunity.limit(3)
    )
  end

  def question_asked
    question = Question.first || FactoryGirl.create(:question)

    Mailer.question_asked(
      question.opportunity.created_by_user,
      question
    )
  end

  def question_answered
    question = Question.answered.first ||
               FactoryGirl.create(:question, :answered)

    Mailer.question_answered(
      question.asked_by_user,
      question
    )
  end
end
