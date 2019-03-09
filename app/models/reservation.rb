class Reservation < ApplicationRecord
  belongs_to :customer, required: true
  belongs_to :accommodation, required: true

  validates :check_in, presence: true
end
