ActiveAdmin.register AccommodationType do
  menu parent: 'Configurações', priority: 1

  config.create_another = true

  scope I18n.t('activerecord.scopes.only_deleted'), :only_deleted

  filter :accommodation
  filter :name

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

  member_action :restore, method: :put do
    resource = AccommodationType.with_deleted.find(params[:id])
    resource.restore

    redirect_to resource_path(resource)
  end
end
