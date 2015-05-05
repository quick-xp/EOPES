# == Schema Information
#
# Table name: map_jumps
#
#  id                   :integer          not null, primary key
#  from_solar_system_id :integer
#  to_solar_system_id   :integer
#  jump                 :integer
#

require 'rails_helper'

RSpec.describe MapJump, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
