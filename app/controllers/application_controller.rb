class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, with: :access_denied
  before_filter :authenticate_user!
  layout :layout_by_resource 

  protected
  def access_denied(exception)
    if current_user.nil?
      message = 'Wrong API key or the user does not exist.'
    else
      message = 'Access denied.'
    end
    respond_to do |format|
      format.json { render json: { error: message }, status: 401 }
    end
  end

  private
  def layout_by_resource 
    if params[:controller] =~ /devise/
      "users" 
    else 
      "application" 
    end 
  end
end
