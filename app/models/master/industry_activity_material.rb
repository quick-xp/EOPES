# == Schema Information
#
# Table name: industryActivityMaterials
#
#  typeID         :integer
#  activityID     :integer
#  materialTypeID :integer
#  quantity       :integer
#  consume        :integer          default("1")
#

class IndustryActivityMaterial < ActiveRecord::Base
  self.table_name = 'industryActivityMaterials'
  establish_connection(:EveMasterDB)
  self.primary_key = :typeID,:activityID,:materialTypeID

end
