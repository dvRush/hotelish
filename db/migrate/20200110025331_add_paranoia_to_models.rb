class AddParanoiaToModels < ActiveRecord::Migration[5.2]
  def change
    add_column  :admin_users, :deleted_at, :datetime
    add_index   :admin_users, :deleted_at

    add_column  :customers, :deleted_at, :datetime
    add_index   :customers, :deleted_at

    add_column  :reservations, :deleted_at, :datetime
    add_index   :reservations, :deleted_at

    add_column  :accommodations, :deleted_at, :datetime
    add_index   :accommodations, :deleted_at
  end
end
