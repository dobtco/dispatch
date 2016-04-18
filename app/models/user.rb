# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  admin_roles            :text             default([]), is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Used for subscriptions
  has_and_belongs_to_many :opportunities
  has_and_belongs_to_many :categories

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # https://github.com/plataformatec/devise/#activejob-integration
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  ## Admin roles

  def self.admin_roles
    @admin_roles ||= LiteEnum.new(:staff, :approver, :admin)
  end

  def staff?
    admin_roles.include?(self.class.admin_roles[:staff].to_s)
  end

  def approver?
    admin_roles.include?(self.class.admin_roles[:approver].to_s)
  end

  def admin?
    admin_roles.include?(self.class.admin_roles[:admin].to_s)
  end
end
