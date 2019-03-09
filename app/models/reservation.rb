class Reservation < ApplicationRecord
  belongs_to :customer, required: true
  belongs_to :accommodation, required: true
  belongs_to :author, optional: true, class_name: 'AdminUser'

  attr_accessor :new_customer

  accepts_nested_attributes_for :customer

  validates :check_in, presence: true

  scope :paids,     -> { where(paid: true) }
  scope :unpaids,   -> { where(paid: true) }
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
end
