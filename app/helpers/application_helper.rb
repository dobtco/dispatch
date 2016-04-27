module ApplicationHelper
  def calculated_page_title
    if content_for(:page_title).present?
      "#{content_for(:page_title)} - #{DispatchConfiguration.site_title}"
    else
      DispatchConfiguration.site_title
    end
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
         "&nbsp".html_safe +
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
end
