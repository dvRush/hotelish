class AddAuthorToReservations < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :author
  end
end
