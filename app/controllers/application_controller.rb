class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions

  def provided_api_key
    params[:api_key] || request.headers['X-API-Key'] || nil
  end

  def current_user
    @current_user ||= User.find_by_api_key(provided_api_key)
  end

  before_filter :authenticate
  def authenticate
    head :unauthorized unless !!current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    head :forbidden
  end
end
