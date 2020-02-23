ActiveAdmin.register Customer do
  menu priority: 3
  
  config.create_another = true

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
      row :source
    end

    panel "Endereço" do
      attributes_table_for customer.address do
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
      f.input :document
      f.input :birthdate, as: :string
      f.input :occupation
      f.input :phone
      f.input :email
      f.input :source

      f.inputs do
        f.has_many :address,
          heading: Address.model_name.human,
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
end
