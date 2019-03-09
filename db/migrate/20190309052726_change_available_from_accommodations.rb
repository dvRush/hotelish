class ChangeAvailableFromAccommodations < ActiveRecord::Migration[5.2]
  def change
    change_column :accommodations, :available, :boolean, default: false
  end
end
