class CreateArrivingsTransport < ActiveRecord::Migration[6.0]
  def change
    create_table :arrivings_transports do |t|
      t.string :name
      t.datetime :deleted_at
      t.integer :reservations_count

      t.timestamps
    end

    add_reference :reservations, :arrivings_transport
  end
end
