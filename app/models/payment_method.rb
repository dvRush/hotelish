class PaymentMethod < ApplicationRecord
  acts_as_paranoid

  has_many :reservations

  validates :name, presence: true, uniqueness: true
end
