class ReservationReason < ApplicationRecord
  acts_as_paranoid

  has_many :reservations

  validates :name, presence: true

  scope :ordered, -> { order(reservations_count: :desc) }
end
