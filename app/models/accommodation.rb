class Accommodation < ApplicationRecord
  self.inheritance_column = :_type

  acts_as_paranoid

  belongs_to :accommodation_type, counter_cache: true
  alias_method :type, :accommodation_type

  has_many :reservations

  validates :title, presence: true, uniqueness: true
  validates :daily_value, numericality: { greather_than: 0 }

  def reserved_in?(check_in:, check_out:)
    reservations.
      paids.
      where(Arel.sql(<<-SQL
        (check_in = :check_in AND check_out = :check_in) OR
        (check_in BETWEEN :check_in AND :check_out) OR
        (check_out BETWEEN :check_in AND :check_out) OR
        (check_in <= :check_in AND check_out >= :check_out)
      SQL
      ), check_in: check_in, check_out: check_out).
      any?
  end

  def available_in?(check_in:, check_out:)
    not reserved_in?(check_in: check_in, check_out: check_out)
  end
end
