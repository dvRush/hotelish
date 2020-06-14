ActiveAdmin.register AdminUser do
  menu priority: 9999

  permit_params :name, :email, :password, :password_confirmation

  filter :name
  filter :email

  scope I18n.t('activerecord.scopes.only_deleted'), :only_deleted

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

  member_action :restore, method: :put do
    resource = AdminUser.with_deleted.find(params[:id])
    resource.restore

    redirect_to resource_path(resource)
  end
end
