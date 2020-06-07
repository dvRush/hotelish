class ReservationDecorator < Draper::Decorator
  using MoneyRefinement

  delegate_all

  def to_s
    "#{model.model_name.human} ##{model.id}"
  end

  def total_amount
    amount_to_money(model.total_amount)
  end

  def discount
    amount_to_money(model.discount)
  end

  private

  def amount_to_money(amount)
    return "" unless amount.present?
    amount.to_money
  end
end
