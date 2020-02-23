class AddFieldsToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :birthdate, :date
    add_column :customers, :occupation, :string
  end
end
