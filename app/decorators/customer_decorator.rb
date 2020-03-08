class CustomerDecorator < Draper::Decorator
  delegate_all

  def document
    h.to_document(model.document)
  end

  def phone
    h.to_phone(model.phone)
  end
end
