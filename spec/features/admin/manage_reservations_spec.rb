require 'rails_helper'

feature 'Manage reservations', js: true do
  before { sign_in }

  scenario 'admin should be able to create, edit and delete reservations' do
    create(:customer, name: 'Seu Madruga')
    create(:customer, name: 'Dona Florinda')
    create(:accommodation, title: 'Flat 101')
    create(:accommodation, title: 'Flat 201')

    click_on 'Reservas'
    click_on 'Novo(a) Reserva'

    select 'Seu Madruga'        , from: 'Cliente'
    select 'Flat 101'           , from: 'Acomodação'
    fill_in 'Check-in'          , with: '01/01/2020 12:00'
    fill_in 'Check-out'         , with: '10/01/2020 12:00'
    fill_in 'Forma de pagamento', with: 'Espécie'
    fill_in 'Fonte de captação' , with: 'OLX'
    check 'Pago'

    click_on 'Criar Reserva'

    expect(page).to have_content 'Seu Madruga'
    expect(page).to have_content 'Flat 101'
    expect(page).to have_content '01 de Janeiro de 2020, 12:00'
    expect(page).to have_content '10 de Janeiro de 2020, 12:00'
    expect(page).to have_content 'Espécie'
    expect(page).to have_content 'OLX'
    expect(page).to have_content 'SIM'

    click_on 'Editar Reserva'

    select 'Dona Florinda'      , from: 'Cliente'
    select 'Flat 201'           , from: 'Acomodação'
    fill_in 'Check-in'          , with: '03/01/2020 12:00'
    fill_in 'Check-out'         , with: '09/01/2020 12:00'
    fill_in 'Forma de pagamento', with: 'Depósito bancário'
    fill_in 'Fonte de captação' , with: 'AirBnb'
    uncheck 'Pago'

    click_on 'Atualizar Reserva'

    expect(page).to have_content 'Dona Florinda'
    expect(page).to have_content 'Flat 201'
    expect(page).to have_content '03 de Janeiro de 2020, 12:00'
    expect(page).to have_content '09 de Janeiro de 2020, 12:00'
    expect(page).to have_content 'Depósito bancário'
    expect(page).to have_content 'AirBnb'
    expect(page).to have_content 'NÃO'

    click_on 'Remover Reserva'

    page.accept_alert

    expect(page).to have_content 'Não existem Reservas ainda.'
  end
end
