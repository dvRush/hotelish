class Accommodation < ApplicationRecord
  self.inheritance_column = :_type

  acts_as_paranoid

  belongs_to :accommodation_type, counter_cache: true
  alias_method :type, :accommodation_type

  has_many :reservations

  validates :title, presence: true, uniqueness: true
  validates :daily_value, numericality: { greather_than: 0 }

  def reserved_in?(check_in:, check_out:, only_paids: false, exclude: [])
    result = reservations
    result = result.where.not(id: Array(exclude)) if exclude.present?

    result.reserved_in(check_in, check_out, only_paids).any?
  end

  def available_in?(**args)
    not reserved_in?(**args)
  end
end
