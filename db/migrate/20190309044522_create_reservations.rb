class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :customer, null: false
      t.references :accommodation, null: false
      t.datetime :check_in
      t.datetime :check_out
      t.string :payment_method
      t.string :source
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
