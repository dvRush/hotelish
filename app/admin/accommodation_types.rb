ActiveAdmin.register AccommodationType do
  menu parent: 'Configurações', priority: 1

  config.create_another = true

  index do
    column :name
    column :description
    actions
  end

  form do |f|
    inputs do
      f.input :name
      f.input :description
    end

    actions
  end

  permit_params :name, :description
end
