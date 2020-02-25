class AddContactSourceToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :contact_source
  end
end
