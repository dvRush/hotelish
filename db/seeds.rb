AdminUser.create!(
  name: 'Admin',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password') if Rails.env.development?
