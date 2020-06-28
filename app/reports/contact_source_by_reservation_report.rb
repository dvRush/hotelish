class ContactSourceByReservationReport
  def initialize(source = Reservation.all)
    @source = source
  end

  def fetch
    source.joins(:contact_source).group("contact_sources.name").count
  end

  private

  attr_reader :source
end
