class AddPaidAtToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :paid_at, :datetime
  end
end
