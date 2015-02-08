class IndustryActivityProduct < ActiveRecord::Base
  self.table_name = 'industryActivityProducts'
  establish_connection(:EveMasterDB)

end