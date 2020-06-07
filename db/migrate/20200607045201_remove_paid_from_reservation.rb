class RemovePaidFromReservation < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :paid
  end
end
