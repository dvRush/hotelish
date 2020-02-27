require 'rails_helper'

feature 'Manage payment methods', js: true do
  before { sign_in }

  scenario 'admin should be able to create, edit and delete payment methods' do
    click_on 'Configurações'
    click_on 'Formas de pagamento'

    expect(page).to have_content 'Não existem Formas de pagamento ainda.'

    click_on 'Novo(a) Forma de pagamento'

    fill_in 'Nome', with: 'Dinheiro'

    click_on 'Criar Forma de pagamento'

    expect(page).to have_content 'Dinheiro'

    click_on 'Editar Forma de pagamento'

    fill_in 'Nome', with: 'Transferência bancária'

    click_on 'Atualizar Forma de pagamento'

    expect(page).to have_content 'Transferência bancária'

    click_on 'Remover Forma de pagamento'

    page.accept_alert

    expect(page).to have_content 'Não existem Formas de pagamento ainda.'
  end

  scenario "admin should be able to select each entry at reservation's form" do
    create(:payment_method, name: "Espécie")
    create(:payment_method, name: "Transferência")
    create(:payment_method, name: "Cartão")

    click_on 'Reservas'
    click_on 'Novo(a) Reserva'

    select 'Espécie',       from: 'Forma de pagamento'
    select 'Transferência', from: 'Forma de pagamento'
    select 'Cartão',        from: 'Forma de pagamento'
  end
end
