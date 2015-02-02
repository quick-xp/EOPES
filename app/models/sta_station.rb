class StaStation < ActiveRecord::Base
  self.table_name = 'staStation'
  establish_connection(:EveMasterDB)
end
