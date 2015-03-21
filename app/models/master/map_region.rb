# == Schema Information
#
# Table name: mapRegions
#
#  regionID   :integer          not null, primary key
#  regionName :string(100)
#  x          :float(53)
#  y          :float(53)
#  z          :float(53)
#  xMin       :float(53)
#  xMax       :float(53)
#  yMin       :float(53)
#  yMax       :float(53)
#  zMin       :float(53)
#  zMax       :float(53)
#  factionID  :integer
#  radius     :float(53)
#

class MapRegion < ActiveRecord::Base
  self.table_name = 'mapRegions'
  self.primary_key = 'regionID'
  establish_connection(:EveMasterDB)

end
