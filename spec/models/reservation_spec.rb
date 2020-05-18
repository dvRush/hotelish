require "rails_helper"

describe Reservation do
  include ActiveSupport::Testing::TimeHelpers

  let(:flat_1) { create(:accommodation) }
  let(:flat_2) { create(:accommodation) }

  let!(:reservation_1) do
    create(:reservation,
      accommodation: flat_1,
      check_in: Time.new(2020,1,1),
      check_out: Time.new(2020,1,14))
  end

  let!(:reservation_2) do
    create(:reservation,
      accommodation: flat_1,
      check_in: Time.new(2020,1,15),
      check_out: Time.new(2020,1,23))
  end

  let!(:reservation_3) do
    create(:reservation,
      accommodation: flat_1,
      check_in: Time.new(2020,1,24),
      check_out: Time.new(2020,1,30))
  end

  let!(:reservation_4) do
    create(:reservation,
      accommodation: flat_2,
      check_in: Time.new(2020,1,24),
      check_out: Time.new(2020,1,30))
  end

  it "reservations must be valid" do
    [
      reservation_1,
      reservation_2,
      reservation_3,
      reservation_4
    ].each do |reservation|
      expect(reservation).to be_valid
    end
  end

  it "must not be possible to create a new reservation for a reserved accommodation" do
    new_reservation = build(:reservation,
      accommodation: flat_1,
      check_in: Time.new(2020,1,28),
      check_out: Time.new(2020,2,1))

    expect(new_reservation).to be_invalid
    expect(new_reservation.errors[:accommodation]).to include("não disponível para estas datas")
  end
end
