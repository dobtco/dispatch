require 'spec_helper'

describe 'Questions' do
  let!(:staff) { create(:user, :staff) }
  let!(:opportunity) { create(:opportunity, :approved, created_by_user: staff) }
  let!(:question) { create(:question, opportunity: opportunity) }

  context 'when questions are disabled' do
    it 'does not show questions' do
      visit opportunity_path(opportunity)
      expect(page).to_not have_text t('questions')
    end
  end

  context 'when questions are enabled' do
    before { opportunity.update(enable_questions: true) }

    it 'shows questions' do
      visit opportunity_path(opportunity)
      expect(page).to have_text t('questions')
      expect(page).to have_text question.question_text
    end

    context 'when logged in as a vendor' do
      let!(:vendor) { create(:user) }

      it 'allows for asking a question' do
        login_as vendor
        visit opportunity_path(opportunity)
        fill_in :question_question_text, with: 'newquestion'

        # Sends a notification
        expect(Mailer).to receive(:question_asked).with(
          opportunity.created_by_user,
          anything
        ).and_return(OpenStruct.new(perform: nil))

        find('#new_question button').click
        expect(page).to have_text 'newquestion'
      end
    end

    context 'as staff' do
      before { login_as staff }

      it 'allows for asking a question but does not notify' do
        visit opportunity_path(opportunity)
        fill_in :question_question_text, with: 'newquestion'
        expect(Mailer).to_not receive(:question_asked)
        find('#new_question button').click
        expect(page).to have_text 'newquestion'
      end

      it 'can answer a question' do
        visit opportunity_path(opportunity)

        # Sends a notification
        expect(Mailer).to receive(:question_answered).with(
          question.asked_by_user,
          question
        ).and_return(OpenStruct.new(perform: nil))

        within '.edit_question' do
          fill_in :question_answer_text, with: 'answertext'
          find('button').click
        end

        expect(page).to have_text 'answertext'
        expect(question.reload).to be_answered
      end

      context 'when question is asked by the current user' do
        before { question.update(asked_by_user: staff) }

        it 'does not send a notification' do
          visit opportunity_path(opportunity)

          # Sends a notification
          expect(Mailer).to_not receive(:question_answered)

          within '.edit_question' do
            fill_in :question_answer_text, with: 'answertext'
            find('button').click
          end

          expect(page).to have_text 'answertext'
        end
      end

      it 'can delete a question' do
        visit opportunity_path(opportunity)
        expect(page).to have_text(question.question_text)
        find('.questions').click_link t('destroy')
        expect(page).to_not have_text(question.question_text)
      end
    end
  end
end
