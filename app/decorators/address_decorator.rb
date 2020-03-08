class AddressDecorator < Draper::Decorator
  delegate_all

  def zip_code
    h.to_zip_code(model.zip_code)
  end
end
