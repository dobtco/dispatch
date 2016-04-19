class SubmissionAdapters::Base
  # The adapter's name. This will be displayed when posting an opportunity
  class_attribute :name

  # If true, we'll display a submission page and look for a template in ...
  class_attribute :submission_page

  def initialize(opportunity)
    @opportunity = opportunity
  end

  def view_proposals_url
  end

  def view_proposals_instructions
  end

  def submit_proposals_url
  end

  def submit_proposals_instructions
  end

  def to_param
    self.class.name.split('::').last.parameterize.underscore
  end
end
