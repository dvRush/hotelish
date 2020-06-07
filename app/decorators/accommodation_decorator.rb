class AccommodationDecorator < Draper::Decorator
  using MoneyRefinement

  delegate_all

  def daily_value
    model.daily_value.to_money
  end
end
