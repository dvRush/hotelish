ActiveAdmin.register Customer do
  menu priority: 3
  
  config.create_another = true

  decorate_with CustomerDecorator

  scope I18n.t('activerecord.scopes.only_deleted'), :only_deleted

  filter :name
  filter :email
  filter :document
  filter :rg
  filter :phone
  filter :birthdate
  filter :occupation
  filter :contact_source
  filter :genre, as: :select, collection: Customer.genre_as_options

  index do
    column do |customer|
      link_to customer.name, admin_customer_path(customer)
    end
    column :phone
    column :document
    column :email

    actions
  end

  show do |customer|
    attributes_table do
      row :name
      row :document
      row :rg
      row :rg_emitter
      row :birthdate
      row :occupation
      row :phone
      row :email
      row(:genre) { customer.genre_text }
      row :contact_source
    end

    panel "Endereço" do
      attributes_table_for customer.address&.decorate do
        row :zip_code
        row :street
        row :number
        row :neighborhood
        row :complement
        row :city
        row :state
        row :country
      end
    end

    panel "Últimas reservas" do
      table_for(
        ReservationDecorator.decorate_collection(
          customer
            .reservations
            .includes(:accommodation)
            .order(created_at: :desc))
      ) do
        column :id do |r|
          link_to r.id, admin_reservation_path(r)
        end
        column :accommodation
        column :num_guests
        column :check_in
        column :check_out
        column :paid_at
        column :total_amount
      end
    end

    active_admin_comments
  end

  form do |f|
    inputs do
      f.input :name
      f.input :document, input_html: {
        data: { mask_document: true }
      }
      f.input :rg
      f.input :rg_emitter
      f.input :birthdate, as: :string, input_html: {
        value: f.object.birthdate&.strftime("%d/%m/%Y"),
        data: { mask_date: true }
      }
      f.input :occupation
      f.input :phone, input_html: { data: { mask_phone: true } }
      f.input :email
      f.input :genre, collection: Customer.genre_as_options
      f.input :contact_source

      f.inputs do
        f.has_many :address,
          heading: Address.model_name.human,
          allow_destroy: false,
          new_record: false do |fa|

          fa.input :zip_code, input_html: { data: { mask_zipcode: true } }
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

    actions
  end

  controller do
    def new
      super do
        @customer.build_address unless @customer.address
      end
    end

    def edit
      super do
        @customer.build_address unless @customer.address
      end
    end
  end

  permit_params :name,
    :email,
    :document,
    :rg,
    :rg_emitter,
    :birthdate,
    :occupation,
    :phone,
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

  member_action :restore, method: :put do
    resource = Customer.with_deleted.find(params[:id])
    resource.restore

    redirect_to resource_path(resource)
  end
end
