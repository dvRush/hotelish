class RemoveTypeFromAccommodation < ActiveRecord::Migration[5.2]
  def up
    remove_column :accommodations, :type
  end

  def down
    add_column :accommodations, :type, :string
  end
end
