class Reservation < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer, required: true
  belongs_to :accommodation, required: true
  belongs_to :author, optional: true, class_name: 'AdminUser'
  belongs_to :contact_source, optional: true

  attr_accessor :new_customer

  accepts_nested_attributes_for :customer

  validates :check_in, presence: true
  validates :num_guests,
    numericality: { greater_than: 0, only_integer: true, allow_nil: true }

  validate :check_out_validation_rules
  validate :avoid_double_reservation

  scope :paids,     -> { where(paid: true) }
  scope :unpaids,   -> { where(paid: false) }
  scope :opens,     -> { where('check_in >= ?', Time.current) }

  scope :actives, -> {
    where('check_in <= :t AND check_out >= :t', t: Time.current)
  }

  scope :previous,  -> {
    where('check_in < :t AND check_out < :t', t: Time.current)
  }

  scope :for_current_month, -> {
    month_range =
      Time.current.at_beginning_of_month..Time.current.at_end_of_month

    where(check_in: month_range)
  }

  private

  def check_out_validation_rules
    return unless check_in? && check_out?
    return unless check_out <= check_in

    errors.add(:check_out, :cannot_be_previous_or_equal_than_check_in)
  end

  def avoid_double_reservation
    return unless check_in? && check_out?
    return unless accommodation
    return if     accommodation.available_in?(check_in: check_in, check_out: check_out)

    errors.add(:accommodation, :not_available_for_these_dates)
  end
end
