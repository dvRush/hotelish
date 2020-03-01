require "rails_helper"

feature "Manage accommodation type", js: true do

  before { sign_in }

  scenario "admin should be able to create, edit and delete accommodations" do
    click_on "Configurações"
    click_on "Tipo de acomodações"

    expect(page).to have_content "Não existem Tipo de acomodações ainda."

    click_on "Novo(a) Tipo de acomodação"

    fill_in "Nome",      with: "Solteiro"
    fill_in "Descrição", with: "Quarto de solteiro com 2 camas"

    click_on "Criar Tipo de acomodação"

    expect(page).to have_content "Solteiro"
    expect(page).to have_content "Quarto de solteiro com 2 camas"

    click_on "Editar Tipo de acomodação"

    fill_in "Nome",      with: "Casal"
    fill_in "Descrição", with: "Quarto de casal com uma cama King"

    click_on "Atualizar Tipo de acomodação"

    expect(page).to have_content "Casal"
    expect(page).to have_content "Quarto de casal com uma cama King"

    click_on "Remover Tipo de acomodação"

    page.accept_alert

    expect(page).to have_content "Não existem Tipo de acomodações ainda."
  end

  scenario "admin should be able to select each type at accommodation's form" do
    create(:accommodation_type, name: "Solteiro")
    create(:accommodation_type, name: "Casado")
    create(:accommodation_type, name: "Solteiro (estúdio)")

    click_on "Acomodações"
    click_on "Novo(a) Acomodação"

    select "Solteiro",            from: "Tipo"
    select "Casado",              from: "Tipo"
    select "Solteiro (estúdio)",  from: "Tipo"
  end
end
