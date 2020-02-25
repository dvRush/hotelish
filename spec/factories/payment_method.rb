FactoryBot.define do
  factory :payment_method do
    sequence(:name) {|i| "Payment method #{i}" }
  end
end
