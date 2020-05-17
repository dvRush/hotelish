ActiveAdmin.register Customer do
  menu priority: 3
  
  config.create_another = true

  decorate_with CustomerDecorator

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
      row :birthdate
      row :occupation
      row :phone
      row :email
      row :contact_source
    end

    panel "Endereço" do
      attributes_table_for customer.address.decorate do
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

    active_admin_comments
  end

  form do |f|
    inputs do
      f.input :name
      f.input :document, input_html: {
        data: { mask_document: true }
      }
      f.input :birthdate, as: :string, input_html: {
        value: f.object.birthdate&.strftime("%d/%m/%Y"),
        data: { mask_date: true }
      }
      f.input :occupation
      f.input :phone, input_html: { data: { mask_phone: true } }
      f.input :email
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
    :birthdate,
    :occupation,
    :phone,
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
end
