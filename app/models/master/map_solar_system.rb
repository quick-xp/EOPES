# == Schema Information
#
# Table name: mapSolarSystems
#
#  regionID        :integer
#  constellationID :integer
#  solarSystemID   :integer          not null, primary key
#  solarSystemName :string(100)
#  x               :float(53)
#  y               :float(53)
#  z               :float(53)
#  xMin            :float(53)
#  xMax            :float(53)
#  yMin            :float(53)
#  yMax            :float(53)
#  zMin            :float(53)
#  zMax            :float(53)
#  luminosity      :float(53)
#  border          :integer
#  fringe          :integer
#  corridor        :integer
#  hub             :integer
#  international   :integer
#  regional        :integer
#  constellation   :integer
#  security        :float(53)
#  factionID       :integer
#  radius          :float(53)
#  sunTypeID       :integer
#  securityClass   :string(2)
#

class MapSolarSystem < ActiveRecord::Base
  self.table_name = 'mapSolarSystems'
  self.primary_key = 'solarSystemID'
  establish_connection(:EveMasterDB)

end
