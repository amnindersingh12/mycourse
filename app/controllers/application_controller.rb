class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :deny_access
  rescue_from ActiveRecord::RecordNotFound, with: :show_record_errors

  private

  def deny_access(exception)
    redirect_to root_url, alert: exception.message
  end

  def show_record_errors(exception)
    redirect_to root_url, alert: exception.message
  end

  def homepage; end
end
