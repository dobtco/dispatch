class MailerPreview < ActionMailer::Preview
  def search_results
    Mailer.search_results(
      User.first,
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

  def approval_request
    Mailer.approval_request(
      User.first,
      Opportunity.first
    )
  end

  def question_deadline
    opp = Opportunity.first
    opp.questions_close_at = Time.now + 1.day + 12.hours

    Mailer.question_deadline(
      User.first,
      opp
    )
  end

  def submission_deadline
    opp = Opportunity.first
    opp.submissions_close_at = Time.now + 1.day + 12.hours

    Mailer.submission_deadline(
      User.first,
      opp
    )
  end
end
