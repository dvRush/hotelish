FactoryBot.define do
  factory :reservation_reason do
    sequence(:name) { |i| "Reservation reason #{i}" }
  end
end

