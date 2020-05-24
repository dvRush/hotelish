class CreateReservationReason < ActiveRecord::Migration[6.0]
  def change
    create_table :reservation_reasons do |t|
      t.string :name
      t.datetime :deleted_at
      t.integer :reservations_count

      t.timestamps
    end

    add_reference :reservations, :reason
  end
end
