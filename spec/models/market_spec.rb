# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  region_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Market, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
