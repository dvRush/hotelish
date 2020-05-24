require "rails_helper"

feature "Manage Customers", js: true do
  before { sign_in }

  scenario "admin should be able to create, edit and delete a customer" do
    create_factories

    click_on "Clientes"
    click_on "Novo(a) Cliente"

    fill_in "Nome",         with: "Jhon Doe"
    fill_in "E-mail",       with: "jhon@doe.com"
    fill_in "Documento",    with: "123.456.789-00"
    fill_in "RG",           with: "123456"
    fill_in "RG (orgão emissor)",  with: "SSP SP"
    fill_in "Data de nascimento", with: "01/01/2001"
    fill_in "Ocupação",     with: "Engenheiro elétrico"
    fill_in "Telefone",     with: "(86) 12345-1234"
    select  "Masculino",    from: "Sexo"
    select  "AirBnb",       from: "Fonte de captação"
    fill_in "CEP",          with: "64123-321"
    fill_in "Logradouro",   with: "Rua Dois de Novembro"
    fill_in "Número",       with: "1234"
    fill_in "Complemento",  with: "Quadra X"
    fill_in "Bairro",       with: "Centro"
    fill_in "Cidade",       with: "Teresina"
    fill_in "Estado",       with: "Piauí"
    fill_in "País",         with: "Brasil"

    click_on "Criar Cliente"

    expect(page).to have_content "Jhon Doe"
    expect(page).to have_content "jhon@doe.com"
    expect(page).to have_content "123.456.789-00"
    expect(page).to have_content "123456"
    expect(page).to have_content "SSP SP"
    expect(page).to have_content "01 de Janeiro de 2001"
    expect(page).to have_content "Engenheiro elétrico"
    expect(page).to have_content "(86) 12345-1234"
    expect(page).to have_content "Masculino"
    expect(page).to have_content "AirBnb"
    expect(page).to have_content "64123-321"
    expect(page).to have_content "Rua Dois de Novembro"
    expect(page).to have_content "1234"
    expect(page).to have_content "Quadra X"
    expect(page).to have_content "Centro"
    expect(page).to have_content "Teresina"
    expect(page).to have_content "Piauí"
    expect(page).to have_content "Brasil"

    click_on "Editar Cliente"

    fill_in "Nome",         with: "Ms Polite"
    fill_in "E-mail",       with: "mr@polite.com"
    fill_in "Documento",    with: "987.654.321-00"
    fill_in "RG",           with: "2345678"
    fill_in "RG (orgão emissor)",  with: "SSP CE"
    fill_in "Data de nascimento", with: "02/02/2002"
    fill_in "Ocupação",     with: "Engenheiro de software"
    fill_in "Telefone",     with: "(68) 54321-4321"
    select  "Feminino",     from: "Sexo"
    select  "OLX",          from: "Fonte de captação"
    fill_in "CEP",          with: "64123-321"
    fill_in "CEP",          with: "64321-123"
    fill_in "Logradouro",   with: "Rua Três de Dezembro"
    fill_in "Número",       with: "4321"
    fill_in "Complemento",  with: "Quadra Y"
    fill_in "Bairro",       with: "Extremo"
    fill_in "Cidade",       with: "Orlando"
    fill_in "Estado",       with: "Florida"
    fill_in "País",         with: "United States"

    click_on "Atualizar Cliente"

    expect(page).to have_content "Ms Polite"
    expect(page).to have_content "mr@polite.com"
    expect(page).to have_content "987.654.321-00"
    expect(page).to have_content "2345678"
    expect(page).to have_content "SSP CE"
    expect(page).to have_content "02 de Fevereiro de 2002"
    expect(page).to have_content "Engenheiro de software"
    expect(page).to have_content "(68) 54321-4321"
    expect(page).to have_content "Feminino"
    expect(page).to have_content "OLX"
    expect(page).to have_content "64321-123"
    expect(page).to have_content "Rua Três de Dezembro"
    expect(page).to have_content "4321"
    expect(page).to have_content "Quadra Y"
    expect(page).to have_content "Extremo"
    expect(page).to have_content "Orlando"
    expect(page).to have_content "Florida"
    expect(page).to have_content "United States"

    click_on "Remover Cliente"

    page.accept_alert

    expect(page).to have_content "Não existem Clientes ainda."
  end

  private

  def create_factories
    create(:contact_source, name: "AirBnb")
    create(:contact_source, name: "OLX")
  end
end
