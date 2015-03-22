# == Schema Information
#
# Table name: trnTranslations
#
#  tcID       :integer          not null
#  keyID      :integer          not null
#  languageID :string(50)       not null
#  text       :text(65535)
#

class TrnTranslation < ActiveRecord::Base
  self.table_name = 'trnTranslations'
  establish_connection(:EveMasterDB)
end
