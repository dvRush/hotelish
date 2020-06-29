class AccommodationTypeByReservationReport
  def fetch(reservations = Reservation.all)
    reservations.joins(accommodation: :accommodation_type).group("accommodation_types.name").count
  end
end
