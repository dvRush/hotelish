FactoryBot.define do
  factory :address do
    for_customer

    street        { "Street Test" }
    neighborhood  { "Neighborhood Test" }
    city          { "City Test" }
    state         { "State Test" }
    country       { "Country Test" }

    trait :for_customer do
      association(:addressable, factory: :customer)
    end
  end
end
