module SubmissionAdapters
  class None < SubmissionAdapters::Base
    self.select_text = 'None of the above'
  end
end
