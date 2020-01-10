class Accommodation < ApplicationRecord
  self.inheritance_column = :_type

  acts_as_paranoid

  validates :title, presence: true
  validates :value, numericality: { greather_than: 0 }
end
