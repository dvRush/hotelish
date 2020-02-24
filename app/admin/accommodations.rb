ActiveAdmin.register Accommodation do
  menu priority: 4

  config.create_another = true

  index do
    column do |accommodation|
      link_to accommodation.title, admin_accommodation_path(accommodation)
    end
    column :accommodation_type
    column :daily_value
    column :available

    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :accommodation_type
      f.input :daily_value
      f.input :available
    end
    f.actions
  end

  permit_params :title, :description, :daily_value, :available, :accommodation_type_id
end
