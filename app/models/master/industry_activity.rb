class IndustryActivity < ActiveRecord::Base
  self.table_name = 'industryActivity'
  establish_connection(:EveMasterDB)
  self.primary_key = :typeID

  def self.get_industry
    IndustryActivity.joins("inner join invTypes on industryActivity.typeID = invTypes.typeID")
                    .joins("inner join trnTranslations on industryActivity.typeID = trnTranslations.keyID")
                    .where(activityID: 1)
                    .where(['languageID = ? and tcID = ?','JA', 8])
                    .select("invTypes.typeID,invTypes.typeName")
                    .order("invTypes.typeName asc")
  end

end
