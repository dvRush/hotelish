class ChangeValueToDailyValueFromAccommodations < ActiveRecord::Migration[5.2]
  def up
    change_table :accommodations do |t|
      t.remove :value
      t.integer :daily_value
    end
  end

  def down
    change_table :accommodations do |t|
      t.decimal :value, precision: 6, scale: 2
      t.remove :daily_value
    end
  end
end
