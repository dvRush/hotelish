class ContactSource < ApplicationRecord
  has_many :reservations
  has_many :customers

  validates :name, presence: true
end
