class Reservation < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer, required: true, counter_cache: true
  belongs_to :accommodation, required: true, counter_cache: true
  belongs_to :author, optional: true, class_name: "AdminUser"
  belongs_to :contact_source, optional: true, counter_cache: true
  belongs_to :payment_method, optional: true, counter_cache: true
  belongs_to :reason, optional: true, class_name: "ReservationReason", counter_cache: true
  belongs_to :arrivings_transport, optional: true, counter_cache: true

  attr_accessor :new_customer

  accepts_nested_attributes_for :customer

  validates :check_in, presence: true
  validates :num_guests,
    numericality: { greater_than: 0, only_integer: true, allow_nil: true }

  validate :check_out_validation_rules
  validate :avoid_double_reservation

  scope :paids,     -> { where(paid: true) }
  scope :unpaids,   -> { where(paid: false) }
  scope :opens,     -> { where("check_in >= ?", Time.current) }

  scope :actives, -> {
    where("check_in <= :t AND check_out >= :t", t: Time.current)
  }

  scope :previous,  -> {
    where("check_in < :t AND check_out < :t", t: Time.current)
  }

  scope :for_current_month, -> {
    month_range =
      Time.current.at_beginning_of_month..Time.current.at_end_of_month

    where(check_in: month_range)
  }

  scope :reserved_from, ->(check_in, check_out, only_paids=false) do
    result = all
    result = result.paids if only_paids
    result = result.
      where(Arel.sql(<<-SQL
        (check_in = :check_in AND check_out = :check_in) OR
        (check_in BETWEEN :check_in AND :check_out) OR
        (check_out BETWEEN :check_in AND :check_out) OR
        (check_in <= :check_in AND check_out >= :check_out)
      SQL
      ), check_in: check_in, check_out: check_out)
  end

  private

  def check_out_validation_rules
    return unless check_in? && check_out?
    return unless check_out <= check_in

    errors.add(:check_out, :cannot_be_previous_or_equal_than_check_in)
  end

  def avoid_double_reservation
    return unless check_in? && check_out?
    return unless accommodation

    return if accommodation.
      available_from?(
        check_in: check_in,
        check_out: check_out,
        only_paids: false,
        exclude: id)

    errors.add(:accommodation, :not_available_for_these_dates)
  end
end
