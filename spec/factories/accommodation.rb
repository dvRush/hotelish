FactoryBot.define do
  factory :accommodation do
    sequence(:title) {|i| "Accommodation #{i}" }
    accommodation_type
    daily_value { 100.0 }
  end
end
