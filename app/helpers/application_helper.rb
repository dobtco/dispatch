module ApplicationHelper
  def site_title
    'Beacon'
  end

  def calculated_page_title
    if content_for(:page_title).present?
      "#{content_for(:page_title)} - #{site_title}"
    else
      site_title
    end
  end

  def parameterized_controller_and_action
    "#{controller_name}-#{action_name}"
  end

  # Workaround for https://github.com/plataformatec/devise/issues/3748
  def flashes_with_consistent_keys
    devise_flash_key_mappings = {
      'notice' => 'success',
      'alert' => 'error'
    }

    flash.
      to_h.
      map { |k, v| { (devise_flash_key_mappings[k.to_s] || k) => v } }.
      reduce(&:merge) || {}
  end

  def sortable_table_header(objects, key, name)
    filterer = objects.filterer

    content_tag(
      :a,
      href: url_for(
        params.merge(
          sort: key,
          page: nil,
          direction: if filterer.sort == key && filterer.direction == 'asc'
                       'desc'
                     else
                       'asc'
                     end
        )
      )
    ) do
      (name +
      (if filterer.sort == key
         ' ' +
         tag(
           :i,
           class: if filterer.direction == 'asc'
                    'fa fa-caret-up'
                  else
                    'fa fa-caret-down'
                  end
         )
       else
         ''
       end)).html_safe
    end
  end

  def pick(obj, *keys)
    stringified_keys = keys.map(&:to_s)

    {}.tap do |h|
      if obj.is_a?(Hash)
        obj.each do |key, value|
          h[key.to_sym] = value if stringified_keys.include?(key.to_s)
        end
      else
        stringified_keys.each do |key|
          if obj.respond_to?(key)
            h[key.to_sym] = obj.send(key)
          end
        end
      end
    end
  end
end
