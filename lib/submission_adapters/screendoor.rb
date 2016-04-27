module SubmissionAdapters
  class Screendoor < SubmissionAdapters::Base
    self.name = 'Screendoor'
    self.submission_page = true

    def view_proposals_url
      'https://screendoor.dobt.co/projects/' \
      "#{@opportunity.submission_adapter_data['embed_token']}/admin"
    end

    def view_proposals_link_text
      "Review submissions&nbsp;&nbsp;<i class='fa fa-external-link'></i>".html_safe
    end

    def submit_proposals_instructions
      'Submissions are accepted online.'
    end
  end
end
