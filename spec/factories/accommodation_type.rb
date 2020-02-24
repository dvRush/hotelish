FactoryBot.define do
  factory :accommodation_type do
    sequence(:name) {|i| "Accommodation Type #{i}" }
  end
end
