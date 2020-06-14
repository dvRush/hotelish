ActiveAdmin.register Accommodation do
  decorate_with AccommodationDecorator

  menu priority: 4

  config.create_another = true

  includes :accommodation_type

  scope I18n.t('activerecord.scopes.only_deleted'), :only_deleted

  filter :title
  filter :daily_value
  filter :available

  index do
    column(Accommodation.model_name.human)do |accommodation|
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
      f.input :accommodation_type, collection: AccommodationType.ordered
      f.input :daily_value, as: :string, input_html: {
        data: { mask_money: true }, maxlength: 8
      }
      f.input :available
    end
    f.actions
  end

  permit_params :title, :description, :daily_value, :available, :accommodation_type_id

  member_action :restore, method: :put do
    resource = Accommodation.with_deleted.find(params[:id])
    resource.restore

    redirect_to resource_path(resource)
  end
end
