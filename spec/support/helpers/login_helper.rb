module Helpers
  def sign_in(admin = nil, password = nil)
    admin ||= create(:admin)
    password ||= "password"

    visit admin_root_path

    fill_in "E-mail", with: admin.email
    fill_in "Senha", with: password

    click_button "Entrar"

    expect(page).to have_content "Logado com sucesso."
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :feature
end
