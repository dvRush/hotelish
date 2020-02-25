require 'rails_helper'

feature 'Manage contact sources', js: true do
  before { sign_in }

  scenario 'admin should be able to create, edit and delete contact sources' do
    click_on 'Configurações'
    click_on 'Fonte de captações'

    expect(page).to have_content 'Não existem Fonte de captações ainda.'

    click_on 'Novo(a) Fonte de captação'

    fill_in 'Nome', with: 'AirBnb'

    click_on 'Criar Fonte de captação'

    expect(page).to have_content 'AirBnb'

    click_on 'Editar Fonte de captação'

    fill_in 'Nome', with: 'OLX'

    click_on 'Atualizar Fonte de captação'

    expect(page).to have_content 'OLX'

    click_on 'Remover Fonte de captação'

    page.accept_alert

    expect(page).to have_content 'Não existem Fonte de captações ainda.'
  end

  scenario "admin should be able to select each entry at reservation's form" do
    create_factories

    click_on 'Reservas'
    click_on 'Novo(a) Reserva'

    select_all_factories_in_form
  end

  scenario "admin should be able to select each entry at customer's form" do
    create_factories

    click_on 'Cliente'
    click_on 'Novo(a) Cliente'

    select_all_factories_in_form
  end

  private

  def create_factories
    create(:contact_source, name: "AirBnb")
    create(:contact_source, name: "OLX")
    create(:contact_source, name: "Google")
  end

  def select_all_factories_in_form
    select 'AirBnb', from: 'Fonte de captação'
    select 'OLX',    from: 'Fonte de captação'
    select 'Google', from: 'Fonte de captação'
  end
end
