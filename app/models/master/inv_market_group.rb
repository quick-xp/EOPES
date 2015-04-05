# == Schema Information
#
# Table name: invMarketGroups
#
#  marketGroupID   :integer          not null, primary key
#  parentGroupID   :integer
#  marketGroupName :string(100)
#  description     :string(3000)
#  iconID          :integer
#  hasTypes        :boolean
#

class InvMarketGroup < ActiveRecord::Base
  belongs_to :EveIcon, foreign_key: "iconID"
  self.table_name = 'invMarketGroups'
  self.primary_key = 'marketGroupID'
  establish_connection(:EveMasterDB)

end
