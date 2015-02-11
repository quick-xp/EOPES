# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate_blueprint do
    type_id 1
    me 1
    te 1
    runs 1
    estimate nil
  end
end
