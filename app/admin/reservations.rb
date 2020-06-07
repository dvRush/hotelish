ActiveAdmin.register Reservation do
  decorate_with ReservationDecorator

  menu priority: 2

  config.create_another = true

  includes :accommodation, :customer

  I18n.with_options(scope: 'activerecord.scopes.reservation') do |i18n|
    scope i18n.t('actives'),            :actives
    scope i18n.t('for_current_month'),  :for_current_month
    scope i18n.t('opens'),              :opens
    scope i18n.t('previous'),           :previous
    scope i18n.t('paids'),              :paids
    scope i18n.t('unpaids'),            :unpaids
  end

  scope I18n.t('activerecord.scopes.only_deleted'), :only_deleted

  filter :customer, input_html: { data: { use_select2: true }}
  filter :check_in
  filter :check_out
  filter :num_guests
  filter :accommodation
  filter :contact_source
  filter :payment_method
  filter :paid_at
  filter :arrivings_transport
  filter :reason
  filter :author

  index do
    id_column

    column :accommodation
    column :customer
    column :check_in
    column :check_out
    column :total_amount
    column :paid_at

    actions(defaults: false) do |resource|
      localizer = ActiveAdmin::Localizers.resource(active_admin_config)

      if resource.deleted?
        item(
          localizer.t(:restore),
          restore_admin_reservation_path(resource),
          class: "restore_link member_link",
          title: localizer.t(:restore),
          method: :put,
          data: { confirm: localizer.t(:restore_confirmation) })
      else
        item(
          localizer.t(:view),
          resource_path(resource),
          class: "view_link member_link",
          title: localizer.t(:view))

        item(
          localizer.t(:edit),
          edit_resource_path(resource),
          class: "edit_link member_link",
          title: localizer.t(:edit))

        item(
          localizer.t(:delete),
          resource_path(resource),
          class: "delete_link member_link",
          title: localizer.t(:delete),
          method: :delete,
          data: { confirm: localizer.t(:delete_confirmation) })
      end
    end
  end

  form do |f|
    inputs 'Cliente' do
      f.input :customer, collection: Customer.all, input_html: { data: { use_select2: true }}

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
        fc.input :document, input_html: { data: { mask_document: true } }
        fc.input :rg
        fc.input :rg_emitter
        fc.input :birthdate, as: :string, input_html: {
          value: fc.object.birthdate&.strftime("%d/%m/%Y"),
          data: { mask_date: true }
        }
        fc.input :occupation
        fc.input :phone, input_html: { data: { mask_phone: true } }
        fc.input :email
        fc.input :genre, collection: Customer.genre_as_options
        fc.input :contact_source

        fc.has_many :address,
          heading: Address.model_name.human,
          allow_destroy: false,
          new_record: false do |fa|

          fa.input :zip_code, input_html: {
            data: { mask_zipcode: true }
          }
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
      f.input :check_in, as: :string, input_html: {
        value: f.object.check_in&.strftime("%d/%m/%Y %H:%M:%S"),
        data: { mask_datetime: true }
      }
      f.input :check_out, as: :string, input_html: {
        value: f.object.check_out&.strftime("%d/%m/%Y %H:%M:%S"),
        data: { mask_datetime: true }
      }
      f.input :num_guests
      f.input :reason
      f.input :arrivings_transport
      f.input :payment_method
      f.input :contact_source
      f.input :total_amount, as: :string, input_html: {
        data: { mask_money: true }, maxlength: 10
      }
      f.input :discount, as: :string, input_html: {
        data: { mask_money: true }, maxlength: 10
      }
      f.input :paid_at, as: :string, input_html: {
        value: f.object.paid_at&.strftime("%d/%m/%Y %H:%M:%S"),
        data: { mask_datetime: true }
      }
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
      reason_id
      arrivings_transport_id
      payment_method_id
      contact_source_id
      total_amount
      discount
      paid_at
    )

    customer_attributes = [
      customer_attributes: [
        :name,
        :document,
        :rg,
        :rg_emitter,
        :occupation,
        :phone,
        :email,
        :birthdate,
        :genre,
        :contact_source_id,
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

  member_action :restore, method: :put do
    resource = Reservation.with_deleted.find(params[:id])
    resource.restore

    redirect_to resource_path(resource)
  end
end
