class ContactSource < ApplicationRecord
  validates :name, presence: true
end
