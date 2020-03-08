module ApplicationHelper
  def to_phone(number)
    number = String(number)

    case number.length
    when 8..9
      number.gsub(/^(\d{4,5})(\d{4})$/, '\1-\2')
    else
      number.gsub(/^0?(\d{2})?(\d{4,5})(\d{4})$/, '(\1) \2-\3')
    end
  end

  def to_document(number)
    number = String(number)

    case number.length
    when 11
      number.gsub(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, '\1.\2.\3-\4')
    when 14
      number.gsub(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, '\1.\2.\3/\4-\5')
    end
  end

  def to_zip_code(number)
    String(number).gsub(/^(\d{5})(\d{3})$/, '\1-\2')
  end
end
