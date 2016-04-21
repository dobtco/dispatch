module BuildEmailAddressHelper
  def build_email_address(email, name)
    address = Mail::Address.new(email)
    address.display_name = name.dup if name.present?
    address.format
  rescue Mail::Field::ParseError
    email
  end
end
