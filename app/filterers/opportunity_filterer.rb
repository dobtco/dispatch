class OpportunityFilterer < Filterer::Base
  sort_option 'title', 'LOWER(title)', default: true
  sort_option 'department', 'LOWER(departments.name)'
  sort_option 'submissions_close_at'

  # def param_text
  # end

  def param_status(x)
    if x == 'open'
      results.submissions_open
    elsif x == 'closed'
      results.submissions_closed
    else
      results
    end
  end

  def param_category_id(x)
    results.with_category(x)
  end

  def defaults
    {
      status: 'open'
    }
  end

  def apply_default_filters
    results.joins(:department)
  end
end
