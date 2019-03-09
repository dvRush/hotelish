ActiveAdmin.register Reservation do
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
