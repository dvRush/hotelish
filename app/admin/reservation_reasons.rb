ActiveAdmin.register ReservationReason do
  menu parent: 'Configurações', priority: 4

  config.create_another = true

  filter :name

  scope I18n.t('activerecord.scopes.only_deleted'), :only_deleted

  index do
    column :name
    actions
  end

  form do |f|
    inputs do
      f.input :name
    end

    actions
  end

  permit_params :name

  member_action :restore, method: :put do
    resource = ReservationReason.with_deleted.find(params[:id])
    resource.restore

    redirect_to resource_path(resource)
  end
end
