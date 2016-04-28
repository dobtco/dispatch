module SubmissionAdapters
  class << self
    mattr_accessor :all_adapters do
      [
        SubmissionAdapters::Email,
        SubmissionAdapters::Screendoor,
        SubmissionAdapters::None
      ]
    end
  end
end
