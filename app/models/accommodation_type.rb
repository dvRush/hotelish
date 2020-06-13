class AccommodationType < ApplicationRecord
  acts_as_paranoid

  has_many :accommodations

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(accommodations_count: :desc) }

  def to_s
    name
  end
end
