# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  permission_level       :integer          default(0), not null
#  business_name          :string
#  business_data          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  omniauth_uid           :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Used for "Subscribe to this opportunity"
  has_and_belongs_to_many :opportunities

  has_many :created_opportunities,
           foreign_key: :created_by_user_id,
           class_name: 'Opportunity',
           dependent: :nullify

  has_many :saved_searches, dependent: :destroy
  has_many :audits, dependent: :destroy

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2, :ldap]

  enum permission_level: [:user, :staff, :approver, :admin]

  scope :approvers_and_admins, -> do
    where(
      # This syntax should be better in Rails 5
      permission_level: User.permission_levels.slice(:approver, :admin).values
    )
  end

  validates :name, presence: true

  serialize :business_data, Hash

  before_create :set_staff_if_email_matches_staff_domain

  attr_accessor :subscribe_to_category_ids
  after_create :create_saved_search_from_category_ids

  attr_accessor :signup_type
  validate :ensure_email_matches_staff_domain

  def self.from_omniauth(access_token)
    provider_uid_string = "#{access_token.provider}|#{access_token.uid}"

    if (user = User.find_by(omniauth_uid: provider_uid_string))
      user
    else
      User.create!(
        omniauth_uid: provider_uid_string,
        email: access_token.info['email'],
        name: access_token.info['name'],
        password: Devise.friendly_token, # Alright, a random password, sure...
        confirmed_at: Time.now
      )
    end
  end

  def omniauthed?
    omniauth_uid.present?
  end

  def omniauth_provider_text
    case omniauth_uid.split('|').first
    when 'google_oauth2'
      'Google'
    when 'ldap'
      'LDAP'
    end
  end

  # https://github.com/plataformatec/devise/#activejob-integration
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def permission_level_is_at_least?(x)
    User.permission_levels[permission_level] >= User.permission_levels[x]
  end

  private

  def set_staff_if_email_matches_staff_domain
    if email_matches_staff_domain?
      self.permission_level = 'staff'
    end
  end

  def email_matches_staff_domain?
    email_domain.in?(DispatchConfiguration.staff_domains)
  end

  def email_domain
    email.split('@').last
  end

  def ensure_email_matches_staff_domain
    if signup_type == :staff && !email_matches_staff_domain?
      errors.add(
        :email,
        I18n.t('activerecord.errors.messages.invalid_staff_domain')
      )
    end
  end

  def create_saved_search_from_category_ids
    sanitized_ids = Array(subscribe_to_category_ids).
                      select { |category_id| category_id.to_s =~ /\A[0-9]+\Z/ }.
                      map(&:to_i).
                      compact

    if sanitized_ids.present?
      saved_searches.create(search_params: { 'category_ids' => sanitized_ids })
    end
  end
end
