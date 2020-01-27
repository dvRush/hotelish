require 'rails_helper'

feature 'Manage accommodations', js: true do
  before { sign_in }

  scenario 'admin should be able to create, edit and delete accommodations' do
    click_on 'Acomodações'
    click_on 'Novo(a) Acomodação'

    fill_in 'Título',          with: 'Flat 101'
    fill_in 'Descrição',       with: 'Description about flat 101'
    fill_in 'Tipo',            with: 'Casal'
    fill_in 'Valor da diária', with: '10000'
    check 'Disponível'

    click_on 'Criar Acomodação'

    expect(page).to have_content 'Flat 101'
    expect(page).to have_content 'Description about flat 101'
    expect(page).to have_content 'Casal'
    expect(page).to have_content '10000'
    expect(page).to have_content 'SIM'

    click_on 'Editar Acomodação'

    fill_in 'Título',          with: 'Flat 201'
    fill_in 'Descrição',       with: 'Description about flat 201'
    fill_in 'Tipo',            with: 'Solteiro (Duplo)'
    fill_in 'Valor da diária', with: '11000'
    uncheck 'Disponível'

    click_on 'Atualizar Acomodação'

    expect(page).to have_content 'Flat 201'
    expect(page).to have_content 'Description about flat 201'
    expect(page).to have_content 'Solteiro (Duplo)'
    expect(page).to have_content '11000'
    expect(page).to have_content 'NÃO'

    click_on 'Remover Acomodação'

    page.accept_alert

    expect(page).to have_content 'Não existem Acomodações ainda.'
  end
end
