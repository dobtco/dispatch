module SubmissionAdapters
  class Base
    # The adapter's name. This will be displayed when posting an opportunity
    class_attribute :name

    # If true, we'll display a submission page and look for a template in ...
    class_attribute :submission_page

    def initialize(opportunity)
      @opportunity = opportunity
    end

    def view_proposals_url
    end

    def view_proposals_link_text
    end

    def submit_proposals_url
    end

    def submit_proposals_instructions
    end

    def submittable?
      submission_page ||
      submit_proposals_url ||
      submit_proposals_instructions
    end

    def self.to_adapter_name
      name.split('::').last
    end

    def self.to_param
      to_adapter_name.parameterize.underscore
    end

    def to_param
      self.class.to_param
    end
  end
end
