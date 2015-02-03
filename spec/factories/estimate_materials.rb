# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate_material do
    type_id 1
    require_count 1
    price "9.99"
    total_price "9.99"
    jita_total_price "9.99"
    jita_average_price "9.99"
    universe_total_price "9.99"
    universe_average_price "9.99"
  end
end
