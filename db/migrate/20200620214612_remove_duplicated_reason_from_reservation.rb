class RemoveDuplicatedReasonFromReservation < ActiveRecord::Migration[6.0]
  def up
    remove_column :reservations, :reason
  end

  def down
    add_column :reservations, :reason, :string
  end
end
