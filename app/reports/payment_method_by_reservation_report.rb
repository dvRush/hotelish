class PaymentMethodByReservationReport
  def fetch(reservations = Reservation.all)
    reservations.joins(:payment_method).group("payment_methods.name").count
  end
end
