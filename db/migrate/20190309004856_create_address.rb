class CreateAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :zip_code
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :complement
      t.string :city
      t.string :state
      t.string :country
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
