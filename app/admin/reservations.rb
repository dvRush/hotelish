ActiveAdmin.register Reservation do
  menu priority: 2

  I18n.with_options(scope: 'activerecord.scopes.reservation') do |i18n|
    scope i18n.t('actives'),            :actives
    scope i18n.t('for_current_month'),  :for_current_month
    scope i18n.t('opens'),              :opens
    scope i18n.t('previous'),           :previous
    scope i18n.t('paids'),              :paids
    scope i18n.t('unpaids'),            :unpaids
  end

  index do
    id_column

    column :accommodation
    column :customer
    column :check_in
    column :check_out
    column :paid

    actions
  end

  form do |f|
    inputs do
      f.input :customer
      f.input :accommodation
      f.input :check_in, as: :string
      f.input :check_out, as: :string
      f.input :payment_method
      f.input :source
      f.input :paid
    end

    actions
  end

  permit_params :customer_id,
    :accommodation_id,
    :check_in,
    :check_out,
    :payment_method,
    :source,
    :paid
end
