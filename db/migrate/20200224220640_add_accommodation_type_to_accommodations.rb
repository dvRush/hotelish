class AddAccommodationTypeToAccommodations < ActiveRecord::Migration[5.2]
  def change
    add_reference :accommodations, :accommodation_type
  end
end
