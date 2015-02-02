class Master::MapRegion < ActiveRecord::Base
  self.table_name = 'mapRegions'
  self.primary_key = 'regionID'
  establish_connection(:EveMasterDB)

end