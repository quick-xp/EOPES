# == Schema Information
#
# Table name: industryActivity
#
#  typeID     :integer          default("0"), not null, primary key
#  time       :integer
#  activityID :integer          default("0"), not null
#

class IndustryActivity < ActiveRecord::Base
  self.table_name = 'industryActivity'
  establish_connection(:EveMasterDB)
  self.primary_key = :typeID

  def self.get_industry
    IndustryActivity.joins("inner join invTypes on industryActivity.typeID = invTypes.typeID")
                    .where(activityID: 1)
                    .where("invTypes.typeName NOT LIKE '%YC117%'")
                    .select("invTypes.typeID,invTypes.typeName")
                    .order("invTypes.typeName asc")
  end

end
