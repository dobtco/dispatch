# == Schema Information
#
# Table name: audits
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  event      :string
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_audits_on_event              (event)
#  index_audits_on_user_id            (user_id)
#  index_audits_on_user_id_and_event  (user_id,event)
#

class Audit < ActiveRecord::Base
  belongs_to :user
  serialize :data, Hash
end
