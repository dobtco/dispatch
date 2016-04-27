class OpportunityFilterer < Filterer::Base
  sort_option 'title', 'LOWER(title)', default: true
  sort_option 'department', 'LOWER(opp_department.name)'
  sort_option 'submissions_close_at'
  sort_option 'updated_at'

  def param_text(x)
    results.full_text(x)
  end

  def param_status(x)
    if x == 'open'
      results.submissions_open
    elsif x == 'closed'
      results.submissions_closed
    else
      results
    end
  end

  def param_category_ids(x)
    category_ids = Array(x).
                    select { |category_id| category_id.to_s =~ /\A[0-9]+\Z/ }.
                    compact

    if category_ids.present?
      results.with_any_category(category_ids)
    else
      results
    end
  end

  def param_department_id(x)
    results.where(department_id: x)
  end

  def defaults
    {
      status: 'open'
    }
  end

  def apply_default_filters
    results.
      # Workaround for pg_search bullshit
      joins('LEFT JOIN departments as opp_department ON opp_department.id = ' \
            'opportunities.department_id')
  end
end
