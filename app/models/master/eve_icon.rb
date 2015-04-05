# == Schema Information
#
# Table name: eveIcons
#
#  iconID      :integer          not null, primary key
#  iconFile    :string(500)      not null
#  description :text(65535)
#

class EveIcon < ActiveRecord::Base
  has_one :InvMarketGroup ,foreign_key: "iconID"
  self.table_name = 'eveIcons'
  self.primary_key = 'iconID'
  establish_connection(:EveMasterDB)

end
