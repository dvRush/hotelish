class CreateAccommodationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :accommodation_types do |t|
      t.string :name, null: false, index: true
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
