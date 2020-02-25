class AddPaymentMethodToReservation < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :payment_method
  end
end
