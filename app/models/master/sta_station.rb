class StaStation < ActiveRecord::Base
  self.table_name = 'staStations'
  establish_connection(:EveMasterDB)
end
