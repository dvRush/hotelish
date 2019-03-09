class Accommodation < ApplicationRecord
  self.inheritance_column = :_type

  validates :title, presence: true
  validates :value, numericality: { greather_than: 0 }
end
