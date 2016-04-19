class SubmissionAdapters::Email < SubmissionAdapters::Base
  self.name = 'Email'

  def submit_proposals_instructions
    %{
      Submissions for this opportunity should be sent via email to
      <a href='mailto:#{submit_to_email}'>#{submit_to_name}</a>.
    }.squish.html_safe
  end

  private

  def submit_to_email
    @opportunity.submission_adapter_data['email']
  end

  def submit_to_name
    @opportunity.submission_adapter_data['name']
  end
end
