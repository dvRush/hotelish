require "rails_helper"

describe Accommodation do
  let(:flat) { create(:accommodation, title: "Flat") }

  context "availability" do
    let(:check_in) { Time.current }
    let(:check_out) { 1.day.from_now }
    let(:available) { flat.available_from?(check_in: check_in, check_out: check_out) }
    let(:reserved) { flat.reserved_from?(check_in: check_in, check_out: check_out) }

    context "when there is no reservations" do
      it("is expected to be available") { expect(available).to eq true }
      it("isn't expected to be reserved") { expect(reserved).to eq false }
    end

    context "when there are reservations" do
      let!(:reservation) do
        create(:reservation, accommodation: flat, check_in: check_in, check_out: check_out)
      end

      it { expect(available).to eq false }
      it { expect(reserved).to eq true }
    end

    context "where check in and check out is out from reservation interval" do
      let!(:reservation) do
        create(:reservation, accommodation: flat, check_in: 2.days.from_now, check_out: 3.days.from_now)
      end

      it("is expected to be available") { expect(available).to eq true }
      it("isn't expected to be reserved") { expect(reserved).to eq false }
    end
  end
end
