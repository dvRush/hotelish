class AccommodationDecorator < Draper::Decorator
  delegate_all

  using MoneyRefinement

  def daily_value
    model.daily_value.to_money
  end
end
