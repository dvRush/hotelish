class AddGenreToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :genre, :string, limit: 1
  end
end
