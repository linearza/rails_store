class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end

  def authorize_admin
    raise ExceptionHandler::Unauthorized, 'You are not authorized to perform this action' unless current_user.admin?
  end
end
