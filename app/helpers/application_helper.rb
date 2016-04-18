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

  # # Workaround for https://github.com/plataformatec/devise/issues/3748
  # def flash_with_devise_mappings
  #   devise_flash_key_mappings = {
  #     'notice' => 'success',
  #     'alert' => 'error'
  #   }
  #
  #   flash.
  #     to_h.
  #     map { |k, v| { (devise_flash_key_mappings[k.to_s] || k) => v } }.
  #     reduce(&:merge) || {}
  # end
end
