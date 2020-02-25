class Customer < ApplicationRecord
  acts_as_paranoid

  belongs_to :contact_source, optional: true

  has_one :address, as: :addressable, dependent: :destroy, required: true

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, email: true, allow_blank: true
end
