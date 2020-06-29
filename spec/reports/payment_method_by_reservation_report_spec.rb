require "rails_helper"

describe PaymentMethodByReservationReport do
  context "#fetch" do
    subject { described_class.new.fetch }

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
