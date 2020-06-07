class ReservationDecorator < Draper::Decorator
  using MoneyRefinement

  delegate_all

  def to_s
    "#{model.model_name.human} ##{model.id}"
  end

  def total_amount
    return "" unless model.total_amount
    model.total_amount.to_money
  end
end
