require "rails_helper"

describe GeneralReport do
  context "#contact_source_by_reservation" do
    subject { described_class.new.contact_source_by_reservation }

    context "when there is no ContactSource" do
      it { is_expected.to eq({}) }
    end

    context "when there are many ContactSource" do
      let(:google) { create(:contact_source, name: "Google") }
      let(:airbnb) { create(:contact_source, name: "AirBnb") }

      before do
        create_list(:reservation, 2, contact_source: google)
        create_list(:reservation, 5, contact_source: airbnb)
      end

      it { is_expected.to include({ "Google" => 2, "AirBnb" => 5 }) }

      context "and at least one has no contact source" do
        before do
          create(:reservation, contact_source: nil)
        end

        it "doesn't list it" do
          is_expected.to include({"Google" => 2, "AirBnb" => 5})
        end
      end
    end
  end

  context "#accommodation_type_by_reservation" do
    subject { described_class.new.accommodation_type_by_reservation }

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

  context "#payment_method_by_reservation" do
    subject { described_class.new.payment_method_by_reservation }

    context "when there is no reservations" do
      it { is_expected.to eq({}) }
    end

    context "when there are many reservations with different payment methods" do
      let(:cash) { create(:payment_method, name: "Cash") }
      let(:debit) { create(:payment_method, name: "Debit") }

      before do
        create_list(:reservation, 3, payment_method: cash)
        create_list(:reservation, 4, payment_method: debit)
      end

      it { is_expected.to include({ "Cash" => 3, "Debit" => 4 }) }

      context "and at least one has no payment method" do
        before { create(:reservation, payment_method: nil) }

        it "doesn't list it" do
          is_expected.to include({"Cash" => 3, "Debit" => 4})
        end
      end
    end
  end
end
