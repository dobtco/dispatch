# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  dobt_user_id          :integer
#  global_remember_token :string
#  local_remember_token  :string
#  profile               :hstore           default({}), not null
#  organizations         :text
#  needs_remote_refresh  :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_dobt_user_id           (dobt_user_id)
#  index_users_on_global_remember_token  (global_remember_token)
#  index_users_on_local_remember_token   (local_remember_token)
#

class User < ActiveRecord::Base
  include DobtAuth::User
end
