class AddContactSourceToReservation < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :contact_source
  end
end
