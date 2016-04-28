module SubmissionAdapters
  class Email < SubmissionAdapters::Base
    self.select_text = 'Email'

    def submit_proposals_instructions
      %(
        Proposals for this opportunity should be sent over email to
        <a href='mailto:#{submit_to_email}'>#{submit_to_name}</a>.
      ).squish.html_safe
    end

    private

    def submit_to_email
      @opportunity.submission_adapter_data['email']
    end

    def submit_to_name
      @opportunity.submission_adapter_data['name']
    end
  end
end
