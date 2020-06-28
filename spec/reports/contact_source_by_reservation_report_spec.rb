require "rails_helper"

describe ContactSourceByReservationReport do
  context "#fetch" do
    subject { described_class.new.fetch }

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
end
