class DatetimePickerInput < SimpleForm::Inputs::StringInput
  def initialize(*)
    super

    # Format value as iso8601 for javascript new Date() compatibility
    if object && (value = object.send(attribute_name))
      input_html_options[:value] = value.iso8601
    end
  end
end
