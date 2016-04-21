class SendDeadlineRemindersJob < ApplicationJob
  def perform
    send_question_reminders
    send_submission_reminders
  end

  private

  def send_question_reminders
    Opportunity.needs_question_deadline_reminders.each do |opportunity|
      opportunity.users.each do |user|
        Mailer.question_deadline(user, opportunity).deliver_later
      end

      opportunity.update(question_deadline_reminder_sent: true)
    end
  end

  def send_submission_reminders
    Opportunity.needs_submission_deadline_reminders.each do |opportunity|
      opportunity.users.each do |user|
        Mailer.submission_deadline(user, opportunity).deliver_later
      end

      opportunity.update(submission_deadline_reminder_sent: true)
    end
  end
end
