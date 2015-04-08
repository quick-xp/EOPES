# == Schema Information
#
# Table name: trnTranslations
#
#  tcID       :integer          not null
#  keyID      :integer          not null
#  languageID :string(50)       not null
#  text       :text(4294967295) not null
#

class TrnTranslation < ActiveRecord::Base
  self.table_name = 'trnTranslations'
  establish_connection(:EveMasterDB)
end
