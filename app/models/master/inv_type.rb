# == Schema Information
#
# Table name: invTypes
#
#  typeID              :integer          not null, primary key
#  groupID             :integer
#  typeName            :string(100)
#  description         :string(3000)
#  mass                :float(53)
#  volume              :float(53)
#  capacity            :float(53)
#  portionSize         :integer
#  raceID              :integer
#  basePrice           :decimal(19, 4)
#  published           :boolean
#  marketGroupID       :integer
#  chanceOfDuplicating :float(53)
#

class InvType < ActiveRecord::Base
  self.table_name = 'invTypes'
  self.primary_key = 'typeID'
  establish_connection(:EveMasterDB)

  def self.get_type_name(typeID)
    InvType.find(typeID).try(:typeName)
  end

  def self.get_description(typeID)
    InvType.find(typeID).try(:description)
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
