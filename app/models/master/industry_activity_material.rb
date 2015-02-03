class IndustryActivityMaterial < ActiveRecord::Base
  self.table_name = 'industryActivityMaterials'
  establish_connection(:EveMasterDB)
  self.primary_key = :typeID,:activityID,:materialTypeID

end