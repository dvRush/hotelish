class ReservationReason < ApplicationRecord
  acts_as_paranoid

  has_many :reservations

  validates :name, presence: true
end
