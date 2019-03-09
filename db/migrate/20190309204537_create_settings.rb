class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.json :value
      t.string :category

      t.timestamps
    end
  end
end
