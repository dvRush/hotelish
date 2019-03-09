class AddSourceToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :source, :string
  end
end
