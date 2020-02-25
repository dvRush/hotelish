class RemoveSourceFromReservations < ActiveRecord::Migration[5.2]
  def up
    remove_column :reservations, :source
  end

  def down
    add_column :reservations, :source, :string
  end
end
