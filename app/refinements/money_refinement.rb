module MoneyRefinement
  refine Integer do
    def to_money
      (self / 100.0).to_s(:currency)
    end
  end

  refine String do
    def to_money
      Integer(self).to_money
    end
  end
end
