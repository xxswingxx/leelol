# app/controllers/users/password_controller.rb
 
class Users::PasswordsController < Devise::PasswordsController
  layout 'users'

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  private :resource_params
end