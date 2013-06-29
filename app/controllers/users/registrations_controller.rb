# app/controllers/users/registrations_controller.rb
 
class Users::RegistrationsController < Devise::RegistrationsController
  layout 'users'

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  private :resource_params
end