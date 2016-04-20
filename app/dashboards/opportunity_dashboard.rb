require 'administrate/base_dashboard'

class OpportunityDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    created_by_user: Field::BelongsTo.with_options(class_name: 'User'),
    approved_by_user: Field::BelongsTo.with_options(class_name: 'User'),
    approved_at: Field::DateTime,
    submitted_at: Field::DateTime,
    department: Field::BelongsTo,
    categories: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    contact_name: Field::String,
    contact_email: Field::String,
    contact_phone: Field::String,
    submission_adapter_name: Field::String,
    publish_at: Field::DateTime,
    submissions_open_at: Field::DateTime,
    submissions_close_at: Field::DateTime,
    enable_questions: Field::Boolean,
    questions_open_at: Field::DateTime,
    questions_close_at: Field::DateTime,
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
    :id,
    :title,
    :department
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :created_by_user,
    :department,
    :categories,
    :id,
    :title,
    :description,
    :contact_name,
    :contact_email,
    :contact_phone,
    :submission_adapter_name,
    :publish_at,
    :submissions_open_at,
    :submissions_close_at,
    :enable_questions,
    :questions_open_at,
    :questions_close_at,
    :created_at,
    :updated_at,
    :approved_by_user,
    :approved_at,
    :submitted_at,
    :deleted_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :created_by_user,
    :department,
    :categories,
    :title,
    :description,
    :contact_name,
    :contact_email,
    :contact_phone,
    :submission_adapter_name,
    :publish_at,
    :submissions_open_at,
    :submissions_close_at,
    :enable_questions,
    :questions_open_at,
    :questions_close_at,
    :approved_by_user,
    :approved_at,
    :submitted_at,
    :deleted_at
  ].freeze

  # Overwrite this method to customize how opportunities are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(opportunity)
    "#{opportunity.title} (##{opportunity.id})"
  end
end
