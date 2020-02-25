class RemoveSourceFromCustomers < ActiveRecord::Migration[5.2]
  def up
    remove_columns :customers, :source
  end

  def down
    add_columns :customers, :source, :string
  end
end
