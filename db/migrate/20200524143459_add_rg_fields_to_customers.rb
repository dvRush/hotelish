class AddRgFieldsToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :rg, :string
    add_column :customers, :rg_emitter, :string
  end
end
