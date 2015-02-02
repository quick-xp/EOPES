class TrnTranslation < ActiveRecord::Base
  self.table_name = 'trnTranslations'
  establish_connection(:EveMasterDB)
end
