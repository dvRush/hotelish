class ContactSource < ApplicationRecord
  acts_as_paranoid

  has_many :reservations
  has_many :customers

  validates :name, presence: true, uniqueness: true
end
