class InvType < ActiveRecord::Base
  self.table_name = 'invTypes'
  self.primary_key = 'typeID'
  establish_connection(:EveMasterDB)

  def self.get_type_name(typeID)
    InvType.find(typeID).try(:typeName)
  end

  def self.get_type_volume(typeID)
    InvType.find(typeID).try(:volume)
  end

  def get_typeName_jp
    TrnTranslation.where(['keyID = ? and languageID = ? and tcID = ?', self.typeID, 'JA', 8]).first.try(:text)
  end

  def get_invType_description_jp
    TrnTranslation.where(['keyID = ? and languageID = ? and tcID = ?', self.typeID, 'JA', 33]).first.try(:text)
  end
end
