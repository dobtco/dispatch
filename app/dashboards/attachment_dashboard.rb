require 'administrate/base_dashboard'

class AttachmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    opportunity: Field::BelongsTo,
    id: Field::Number,
    upload: Field::String,
    content_type: Field::String,
    file_size_bytes: Field::Number,
    has_thumbnail: Field::Boolean,
    deleted_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :opportunity,
    :id,
    :upload,
    :content_type
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :opportunity,
    :id,
    :upload,
    :content_type,
    :file_size_bytes,
    :has_thumbnail,
    :deleted_at,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :opportunity,
    :upload,
    :content_type,
    :file_size_bytes,
    :has_thumbnail,
    :deleted_at
  ].freeze

  # Overwrite this method to customize how attachments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(attachment)
  #   "Attachment ##{attachment.id}"
  # end
end
