class RemovePaymentMethodFromReservations < ActiveRecord::Migration[5.2]
  def up
    remove_column :reservations, :payment_method
  end

  def down
    add_column :reservations, :payment_method, :string
  end
end
