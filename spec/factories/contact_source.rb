FactoryBot.define do
  factory :contact_source do
    sequence(:name) {|i| "Contact Source #{i}" }
  end
end
