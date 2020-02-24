class CreateContactSources < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_sources do |t|
      t.string :name, null: false, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
