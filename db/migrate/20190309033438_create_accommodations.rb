class CreateAccommodations < ActiveRecord::Migration[5.2]
  def change
    create_table :accommodations do |t|
      t.string :title, null: false
      t.text :description
      t.string :type
      t.decimal :value, precision: 6, scale: 2
      t.boolean :available

      t.timestamps
    end
  end
end
