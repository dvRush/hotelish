class Customer < ApplicationRecord
  acts_as_paranoid

  GENRE_OPTIONS = { male: "M", female: "F" }

  belongs_to :contact_source, optional: true, counter_cache: true

  has_one :address, as: :addressable, dependent: :destroy, required: true

  has_many :reservations

  enum genre: GENRE_OPTIONS

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, email: true, allow_blank: true

  def self.genre_as_options
    GENRE_OPTIONS.map do |key, _|
      [
        I18n.t("#{genre_enum_i18n_key}.#{key}"),
        key
      ]
    end
  end

  def genre_text
    return "" if self.genre.blank?
    I18n.t("#{self.class.genre_enum_i18n_key}.#{self.genre}")
  end

  private

  def self.genre_enum_i18n_key
    "activerecord.enums.#{self.to_s.tableize.singularize}.genre"
  end
end
