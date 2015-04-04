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
#  published           :integer
#  marketGroupID       :integer
#  chanceOfDuplicating :float(53)
#

class InvType < ActiveRecord::Base
  self.table_name = 'invMarketGroups'
  self.primary_key = 'marketGroupID'
  establish_connection(:EveMasterDB)

end
