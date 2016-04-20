SimpleForm::Inputs::Base.default_options = {
  # Add the 'control' class to radio/checkbox labels
  item_label_class: 'control'
}

SimpleForm.setup do |config|
  def generate_wrapper(config, name, tag, mod)
    config.wrappers name, tag: tag, class: "form_item form_item_#{mod}", error_class: 'error' do |b|
      b.use :html5
      b.use :placeholder
      b.use(:judge) if defined?(Judge)

      b.wrapper tag: 'div', class: "form_item_#{mod}_label" do |ba|
        if tag == :div
          ba.use :label
        elsif tag == :fieldset
          ba.use :legend
        end
      end

      b.wrapper tag: 'div', class: "form_item_#{mod}_input" do |ba|
        ba.use :input
        ba.use :error, wrap_with: { tag: 'span', class: 'form_error' }
        ba.use :hint,  wrap_with: { tag: 'div', class: 'form_hint' }
      end
    end
  end

  generate_wrapper config, :horizontal, :div, 'horiz'
  generate_wrapper config, :horizontal_fieldset, :fieldset, 'horiz'
  generate_wrapper config, :vertical, :div, 'vert'
  generate_wrapper config, :vertical_fieldset, :fieldset, 'vert'

  config.default_wrapper = :vertical

  # Boolean checkboxes
  config.boolean_style = :nested
  config.boolean_label_class = 'control'

  # Default button class
  config.button_class = 'button'

  # Don't wrap checkboxes/radios *again*
  config.item_wrapper_tag = false

  config.label_text = lambda do |label, required, _|
    if required.present?
      "#{ERB::Util.h(label)}&nbsp;#{required}".html_safe
    else
      label
    end
  end
end
