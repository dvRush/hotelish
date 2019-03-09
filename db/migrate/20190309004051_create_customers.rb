class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email
      t.string :document
      t.string :phone

      t.timestamps
    end
  end
end
