class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  layout :layout_by_resource 

  def layout_by_resource 
    if params[:controller] =~ /devise/
      "users" 
    else 
      "application" 
    end 
  end
end
