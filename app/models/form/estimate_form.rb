class Form::EstimateForm
  include ActiveModel::Model

  attr_accessor :sell_price,:runs,:sell_count
  attr_accessor :blueprint_type_id,:blueprint_me,:blueprint_te
  attr_accessor :region_id,:solar_system_id
  attr_accessor :user_id
end