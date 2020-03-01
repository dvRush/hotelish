require "rails_helper"

feature "Manage reservations", js: true do
  let(:admin) { create(:admin, name: "Senhor Barriga") }

  before { sign_in admin }

  scenario "admin should be able to create, edit and delete reservations" do
    create_factories

    click_on "Reservas"
    click_on "Novo(a) Reserva"

    select "Seu Madruga",     from: "Cliente"
    select "Flat 101",        from: "Acomodação"
    fill_in "Check-in",       with: "01/01/2020 12:00"
    fill_in "Check-out",      with: "10/01/2020 12:00"
    fill_in "Num. hóspedes",  with: "1"
    select "Espécie",         from: "Forma de pagamento"
    select "OLX",             from: "Fonte de captação"
    check "Pago"

    click_on "Criar Reserva"

    within "#main_content" do
      expect(page).to have_content "Seu Madruga"
      expect(page).to have_content "Flat 101"
      expect(page).to have_content "01 de Janeiro de 2020, 12:00"
      expect(page).to have_content "10 de Janeiro de 2020, 12:00"
      expect(page).to have_content "Espécie"
      expect(page).to have_content "OLX"
      expect(page).to have_content "SIM"
      expect(page).to have_content "1"
      expect(page).to have_content "Senhor Barriga"
    end

    click_on "Editar Reserva"

    select "Dona Florinda",     from: "Cliente"
    select "Flat 201",          from: "Acomodação"
    fill_in "Check-in",         with: "03/01/2020 12:00"
    fill_in "Check-out",        with: "09/01/2020 12:00"
    fill_in "Num. hóspedes",    with: "2"
    select "Depósito bancário", from: "Forma de pagamento"
    select "AirBnb",            from: "Fonte de captação"
    uncheck "Pago"

    click_on "Atualizar Reserva"

    within "#main_content" do
      expect(page).to have_content "Dona Florinda"
      expect(page).to have_content "Flat 201"
      expect(page).to have_content "03 de Janeiro de 2020, 12:00"
      expect(page).to have_content "09 de Janeiro de 2020, 12:00"
      expect(page).to have_content "Depósito bancário"
      expect(page).to have_content "AirBnb"
      expect(page).to have_content "NÃO"
      expect(page).to have_content "2"
      expect(page).to have_content "Senhor Barriga"
    end

    click_on "Remover Reserva"

    page.accept_alert

    expect(page).to have_content "Não existem Reservas ainda."
  end

  scenario "admin browsing by reservations scopes" do
    flat_101 = create(:accommodation, title: "Flat 101")
    flat_102 = create(:accommodation, title: "Flat 102")
    flat_103 = create(:accommodation, title: "Flat 103")
    flat_104 = create(:accommodation, title: "Flat 104")
    flat_105 = create(:accommodation, title: "Flat 105")
    flat_106 = create(:accommodation, title: "Flat 106")

    # Previous
    create(:reservation,
      accommodation: flat_101,
      check_in: 10.days.ago,
      check_out: 5.days.ago)

    # Actives
    create(:reservation,
      accommodation: flat_102,
      check_in: 10.days.ago,
      check_out: 10.days.from_now)

    # Paids
    create(:reservation, accommodation: flat_103, paid: true)

    # Unpaids
    create(:reservation, accommodation: flat_104, paid: false)

    # Opens
    create(:reservation,
      accommodation: flat_105,
      check_in: 60.days.from_now,
      check_out: 70.days.from_now)

    # For current month
    create(:reservation,
      accommodation: flat_106,
      check_in: Time.current.at_beginning_of_month,
      check_out: Time.current.at_end_of_month)

    click_on "Reservas"

    within "#main_content" do
      click_on "Anteriores"
      expect(page).to have_content "Flat 101"

      click_on "Ativas"
      expect(page).to have_content "Flat 102"

      click_on "Pagas"
      expect(page).to have_content "Flat 103"

      click_on "Não pagas"
      expect(page).to have_content "Flat 104"

      click_on "Abertas"
      expect(page).to have_content "Flat 105"

      click_on "Neste mês"
      expect(page).to have_content "Flat 106"
    end
  end

  scenario "admin should be able to create a new reservation with " \
   "a new customer in the same page" do

    create_factories

    click_on "Reservas"
    click_on "Novo(a) Reserva"

    check "Adicionar novo"

    fill_in "Nome",         with: "Jhon Doe"
    fill_in "E-mail",       with: "jhon@doe.com"
    fill_in "Documento",    with: "123.456.789-00"
    fill_in "Telefone",     with: "(86) 12345-1234"
    fill_in "CEP",          with: "64123-321"
    fill_in "Logradouro",   with: "Rua Dois de Novembro"
    fill_in "Número",       with: "1234"
    fill_in "Complemento",  with: "Quadra X"
    fill_in "Bairro",       with: "Centro"
    fill_in "Cidade",       with: "Teresina"
    fill_in "Estado",       with: "Piauí"
    fill_in "País",         with: "Brasil"

    select "Flat 101",    from: "Acomodação"
    fill_in "Check-in",   with: "01/01/2020 12:00"
    fill_in "Check-out",  with: "10/01/2020 12:00"
    select "Espécie",     from: "Forma de pagamento"

    check "Pago"

    click_on "Criar Reserva"

    within "#main_content" do
      expect(page).to have_content "Detalhes do(a) Reserva"

      expect(page).to have_content "Flat 101"
      expect(page).to have_content "01 de Janeiro de 2020, 12:00"
      expect(page).to have_content "10 de Janeiro de 2020, 12:00"
      expect(page).to have_content "Espécie"
      expect(page).to have_content "SIM"
      expect(page).to have_content "Senhor Barriga"
    end
  end

  private

  def create_factories
    create(:contact_source, name: "AirBnb")
    create(:contact_source, name: "OLX")

    create(:customer, name: "Seu Madruga")
    create(:customer, name: "Dona Florinda")

    create(:accommodation, title: "Flat 101")
    create(:accommodation, title: "Flat 201")

    create(:payment_method, name: "Espécie")
    create(:payment_method, name: "Depósito bancário")
  end
end
