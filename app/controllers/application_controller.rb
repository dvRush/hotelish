class ApplicationController < ActionController::Base
  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      current_admin_user: current_admin_user
    }
  end
end
