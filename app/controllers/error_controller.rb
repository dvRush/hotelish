class ErrorController < ApplicationController
  def index
    raise "This is my custom error"
  end
end
