class AddCounterCaches < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_methods, :reservations_count, :integer, default: 0
    add_column :customers, :reservations_count, :integer, default: 0
    add_column :accommodations, :reservations_count, :integer, default: 0
    add_column :contact_sources, :reservations_count, :integer, default: 0
    add_column :contact_sources, :customers_count, :integer, default: 0
    add_column :accommodation_types, :accommodations_count, :integer, default: 0
  end
end
