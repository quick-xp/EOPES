# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :market_price do
    type_id 1
    adjusted_price "9.99"
    average_price "9.99"
  end
end
