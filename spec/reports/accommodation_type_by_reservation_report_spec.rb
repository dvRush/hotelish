require "rails_helper"

describe AccommodationTypeByReservationReport do
  context "#fetch" do
    subject { described_class.new.fetch }

    context "when there is no reservations" do
      it { is_expected.to eq({}) }
    end

    context "when there are many reservations with different accommodation types" do
      let(:single) { create(:accommodation_type, name: "Single") }
      let(:double) { create(:accommodation_type, name: "Double") }

      before do
        accommodation_single = create(:accommodation, accommodation_type: single)
        accommodation_double = create(:accommodation, accommodation_type: double)

        create_list(:reservation, 1, :skip_validation, accommodation: accommodation_single)
        create_list(:reservation, 2, :skip_validation, accommodation: accommodation_double)
      end

      it { is_expected.to include({ "Single" => 1, "Double" => 2 }) }
    end
  end
end
