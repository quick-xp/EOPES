# == Schema Information
#
# Table name: mapSolarSystemJumps
#
#  fromRegionID        :integer
#  fromConstellationID :integer
#  fromSolarSystemID   :integer          not null
#  toSolarSystemID     :integer          not null
#  toConstellationID   :integer
#  toRegionID          :integer
#

class MapSolarSystemJumps < ActiveRecord::Base
  self.table_name = 'mapSolarSystemJumps'
  establish_connection(:EveMasterDB)

end
