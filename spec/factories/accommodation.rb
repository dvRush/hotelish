FactoryBot.define do
  factory :accommodation do
    sequence(:title) {|i| "Accommodation #{i}" }
    daily_value { 100.0 }
  end
end
