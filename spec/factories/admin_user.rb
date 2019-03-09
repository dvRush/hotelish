FactoryBot.define do
  factory :admin, class: AdminUser do
    sequence(:name) {|i| "Admin #{i}" }
    sequence(:email) {|i| "admin_#{i}@example.com" }
    password { 'password' }
  end
end
