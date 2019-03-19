ActiveAdmin.register Reservation do
  menu priority: 2

  I18n.with_options(scope: 'activerecord.scopes.reservation') do |i18n|
    scope i18n.t('actives'),            :actives
    scope i18n.t('for_current_month'),  :for_current_month
    scope i18n.t('opens'),              :opens
    scope i18n.t('previous'),           :previous
    scope i18n.t('paids'),              :paids
    scope i18n.t('unpaids'),            :unpaids
  end

  index do
    id_column

    column :accommodation
    column :customer
    column :check_in
    column :check_out
    column :paid

    actions
  end

  form do |f|
    inputs 'Cliente' do
      f.input :customer
      f.input :new_customer, as: :boolean,
        input_html: {
          data: {
            if: 'checked',
            action: 'slide',
            gtarget: '.new_customer_form'
          }
        }

      f.has_many :customer,
        heading: false,
        allow_destroy: false,
        new_record: false, class: 'new_customer_form without_remove_button' do |fc|

        fc.input :name
        fc.input :document
        fc.input :phone
        fc.input :email
        fc.input :source

        fc.has_many :address,
          allow_destroy: false,
          new_record: false do |fa|

          fa.input :zip_code
          fa.input :street
          fa.input :number
          fa.input :neighborhood
          fa.input :complement
          fa.input :city
          fa.input :state
          fa.input :country, as: :string
        end
      end
    end

    inputs 'Informações da reserva' do
      f.input :accommodation
      f.input :check_in, as: :string
      f.input :check_out, as: :string
      f.input :num_guests
      f.input :payment_method
      f.input :source
      f.input :paid
    end

    actions
  end

  permit_params do
    params = %i(
      customer_id
      accommodation_id
      check_in
      check_out
      num_guests
      payment_method
      source
      paid
    )

    customer_attributes = [
      customer_attributes: [
        :name,
        :document,
        :phone,
        :email,
        :source,
        address_attributes: [
          :zip_code,
          :street,
          :number,
          :neighborhood,
          :complement,
          :city,
          :state,
          :country
        ]
      ]
    ]

    params.push customer_attributes if %w(new create).include? action_name
    params.push :new_customer if %w(new create).include? action_name
    params.push :author_id    if action_name.eql? 'create'
    params
  end

  controller do
    def new
      super do
        @reservation.customer ||= Customer.new
        @reservation.customer.address ||= Address.new
      end
    end

    def create
      params[:reservation][:author_id] = current_admin_user.id

      if params.dig(:reservation, :customer_id).present?
        params[:reservation].delete(:customer_attributes)
      end

      super
      @reservation.customer ||= Customer.new
      @reservation.customer.address ||= Address.new
    end
  end
end
