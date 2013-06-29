class TokensController < ApplicationController
  def create
    current_user.reset_authentication_token!
    redirect_to edit_user_registration_path(current_user)
  end

  def destroy
    current_user.update_attribute(:authentication_token, nil)
    redirect_to edit_user_registration_path(current_user)
  end
end