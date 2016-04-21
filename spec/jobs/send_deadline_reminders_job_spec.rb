require 'spec_helper'

describe SendDeadlineRemindersJob do
  let!(:user) { create(:user) }
  let!(:opportunity) do
    create(
      :opportunity,
      :approved,
      enable_questions: true,
      questions_close_at:
        Time.now +
        Configuration.question_deadline_reminder_hours.hours -
        20.minutes,
      submissions_close_at:
        Time.now +
        Configuration.submission_deadline_reminder_hours.hours -
        20.minutes
    )
  end

  context 'when the user is not subscribed' do
    it 'does not send notifications' do
      expect { described_class.perform_now }.
        to_not change { ActionMailer::Base.deliveries.length }
    end
  end

  context 'when the user is subscribed' do
    before { user.opportunities << opportunity }

    it 'sends notifications' do
      expect { described_class.perform_now }.
        to change { ActionMailer::Base.deliveries.length }.by(2)
    end

    context 'when a notification is already sent' do
      before { opportunity.update(submission_deadline_reminder_sent: true) }

      it 'only sends new notifications' do
        expect { described_class.perform_now }.
          to change { ActionMailer::Base.deliveries.length }.by(1)
      end
    end
  end
end
