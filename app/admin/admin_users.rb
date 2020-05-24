ActiveAdmin.register AdminUser do
  menu priority: 9999

  permit_params :name, :email, :password, :password_confirmation

  filter :name
  filter :email

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    actions
  end

  filter :name
  filter :email

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
