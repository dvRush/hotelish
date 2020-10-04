class GeneralReport
  attr_reader :reservations

  def initialize(reservations = nil)
    @reservations = reservations || Reservation.all
  end

  def payment_method_by_reservation
    reservations.joins(:payment_method).group("payment_methods.name").count
  end

  def accommodation_type_by_reservation
    reservations.joins(accommodation: :accommodation_type).group("accommodation_types.name").count
  end

  def contact_source_by_reservation
    reservations.joins(:contact_source).group("contact_sources.name").count
  end
end
