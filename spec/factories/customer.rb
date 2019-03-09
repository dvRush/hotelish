FactoryBot.define do
  factory :customer do
    sequence(:name) {|i| "Customer #{i}" }

    after(:build) do |customer, evaluator|
      customer.address = build(:address, addressable: customer)
    end
  end
end
