class AddReasonToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :reason, :string
  end
end
