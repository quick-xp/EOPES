# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate_job_cost do
    region_id 1
    solar_system_id 1
    system_cost_index "9.99"
    base_job_cost "9.99"
    base_job_cost "9.99"
    job_fee "9.99"
    facility_cost "9.99"
    total_job_cost "9.99"
    estimate nil
  end
end
