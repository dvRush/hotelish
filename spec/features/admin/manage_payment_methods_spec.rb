require 'rails_helper'

feature 'Manage payment methods', js: true do
  before { sign_in }

  scenario 'admin should be able to create, edit and delete payment methods' do
    click_on 'Configurações'
    click_on 'Métodos de pagamento'

    expect(page).to have_content 'Não existem Métodos de pagamento ainda.'

    click_on 'Novo(a) Método de pagamento'

    fill_in 'Nome', with: 'Dinheiro'

    click_on 'Criar Método de pagamento'

    expect(page).to have_content 'Dinheiro'

    click_on 'Editar Método de pagamento'

    fill_in 'Nome', with: 'Transferência bancária'

    click_on 'Atualizar Método de pagamento'

    expect(page).to have_content 'Transferência bancária'

    click_on 'Remover Método de pagamento'

    page.accept_alert

    expect(page).to have_content 'Não existem Métodos de pagamento ainda.'
  end
end
