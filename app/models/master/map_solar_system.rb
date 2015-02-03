class MapSolarSystem < ActiveRecord::Base
  self.table_name = 'mapSolarSystems'
  self.primary_key = 'solarSystemID'
  establish_connection(:EveMasterDB)

end
