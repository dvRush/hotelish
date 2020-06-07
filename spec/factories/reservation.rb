FactoryBot.define do
  factory :reservation do
    customer
    accommodation

    check_in  { 10.days.from_now }
    check_out { 15.days.from_now }

    trait :paid do
      paid_at { Time.current }
    end
  end
end
