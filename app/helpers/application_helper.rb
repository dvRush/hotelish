module ApplicationHelper
  using MoneyRefinement

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

  def to_money(number)
    number.to_money
  end

  def label_value(object, attribute, **options)
    label = object.class.human_attribute_name(attribute)
    value = object.public_send(attribute)
    separator = options.fetch(:separator, ": ")

    if value.present?
      value = case options[:as]&.to_sym
        when :date, :datetime
          options[:format] ? l(value, format: options[:format]) : l(value)
        when :money then to_money(value)
        when :zip_code then to_zip_code(value)
        when :phone then to_phone(value)
        when :document then to_document(value)
        else
          value
        end
    end

    if block_given?
      yield label, value, separator
    else
      [label, separator, value].compact.join("")
    end
  end

  def table_label_value(label, value, **options)
    if not(label.is_a?(String)) && label.respond_to?(value)
      label_value(label, value, **options) do |lab, val, sep|
        label = lab + sep
        value = val
      end
    end

    label_class = options.delete(:label_class) || "label"
    value_class = options.delete(:value_class) || "value"

    content_tag :td, **options do
      content_tag(:p, label, class: label_class) + content_tag(:p, value, class: value_class)
    end
  end
end
