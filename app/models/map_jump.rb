# == Schema Information
#
# Table name: map_jumps
#
#  id                   :integer          not null, primary key
#  from_solar_system_id :integer
#  to_solar_system_id   :integer
#  jump                 :integer
#

class MapJump < ActiveRecord::Base
end
