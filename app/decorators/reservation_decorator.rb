class ReservationDecorator < Draper::Decorator
  using MoneyRefinement

  delegate_all

  def total_amount
    return "" unless model.total_amount
    model.total_amount.to_money
  end
end
