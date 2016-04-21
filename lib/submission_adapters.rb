module SubmissionAdapters
  class << self
    mattr_accessor :all_adapters do
      [
        SubmissionAdapters::None,
        SubmissionAdapters::Screendoor,
        SubmissionAdapters::Email
      ]
    end
  end
end
