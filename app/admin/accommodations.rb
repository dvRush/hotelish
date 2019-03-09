ActiveAdmin.register Accommodation do
  menu priority: 4

  index do
    column do |accommodation|
      link_to accommodation.title, admin_accommodation_path(accommodation)
    end
    column :type
    column :value
    column :available

    actions
  end

  permit_params :title, :description, :type, :value, :available
end
