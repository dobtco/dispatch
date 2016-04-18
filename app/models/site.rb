# == Schema Information
#
# Table name: sites
#
#  id               :integer          not null, primary key
#  organization_app :hstore           default({}), not null
#  organization     :hstore           default({}), not null
#  app_plan         :text
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Site < ActiveRecord::Base
  include DobtAuth::Site
end
