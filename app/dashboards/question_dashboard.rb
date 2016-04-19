require "administrate/base_dashboard"

class QuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    opportunity: Field::BelongsTo,
    asked_by_user: Field::BelongsTo.with_options(class_name: "User"),
    answered_by_user: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::Number,
    asked_by_user_id: Field::Number,
    answered_by_user_id: Field::Number,
    question_text: Field::Text,
    answer_text: Field::Text,
    answered_at: Field::DateTime,
    deleted_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :opportunity,
    :asked_by_user,
    :answered_by_user,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :opportunity,
    :asked_by_user,
    :answered_by_user,
    :id,
    :asked_by_user_id,
    :answered_by_user_id,
    :question_text,
    :answer_text,
    :answered_at,
    :deleted_at,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :opportunity,
    :asked_by_user,
    :answered_by_user,
    :asked_by_user_id,
    :answered_by_user_id,
    :question_text,
    :answer_text,
    :answered_at,
    :deleted_at
  ]

  # Overwrite this method to customize how questions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(question)
  #   "Question ##{question.id}"
  # end
end
