class AddAmountAndDiscountToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :total_amount, :integer
    add_column :reservations, :discount, :integer
  end
end
