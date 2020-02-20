ActiveAdmin.register Accommodation do
  menu priority: 4

  config.create_another = true

  index do
    column do |accommodation|
      link_to accommodation.title, admin_accommodation_path(accommodation)
    end
    column :type
    column :daily_value
    column :available

    actions
  end

  permit_params :title, :description, :type, :daily_value, :available
end
