class AccommodationType < ApplicationRecord
  acts_as_paranoid

  has_many :accommodations

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
