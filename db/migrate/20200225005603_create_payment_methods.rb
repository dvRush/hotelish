class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.string :name, null: false, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
