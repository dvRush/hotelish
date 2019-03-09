class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, required: true

  validates :street, presence: true
  validates :number,
    numericality: { only_integer: true, greather_than: 0, allow_blank: true }
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
end
