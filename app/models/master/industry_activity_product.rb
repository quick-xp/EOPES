# == Schema Information
#
# Table name: industryActivityProducts
#
#  typeID        :integer
#  activityID    :integer
#  productTypeID :integer
#  quantity      :integer
#

class IndustryActivityProduct < ActiveRecord::Base
  self.table_name = 'industryActivityProducts'
  establish_connection(:EveMasterDB)

end
