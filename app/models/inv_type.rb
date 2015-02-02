class InvType < ActiveRecord::Base
  self.table_name = 'invTypes'
  self.primary_key = 'typeID'
  establish_connection(:EveMasterDB)

  def get_typeName_jp
    TrnTranslation.where(['keyID = ? and languageID = ? and tcID = ?', self.typeID, 'JA', 8]).first.try(:text)
  end

  def get_invType_description_jp
    TrnTranslation.where(['keyID = ? and languageID = ? and tcID = ?', self.typeID, 'JA', 33]).first.try(:text)
  end
end
