class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    if request.headers["HTTP_API_USER_TOKEN"].present? && (user = User.find_by(id: request.headers["HTTP_API_USER_TOKEN"]))
      User.current_user = user
      return true
    else
      head :unauthorized
      return false
    end
  end
end
