FactoryBot.define do
  factory :accommodation do
    sequence(:title) {|i| "Accommodation #{i}" }
    value { 100.0 }
  end
end
