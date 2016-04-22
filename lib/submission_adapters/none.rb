module SubmissionAdapters
  class None < SubmissionAdapters::Base
    self.name = 'None'

    def submit_proposals_instructions
      %(
        Look at the opportunity description for details on submitting a proposal.
      )
    end
  end
end
