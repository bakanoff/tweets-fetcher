class SessionsController < ApplicationController
  def create
    if auth_hash
      @user = User.find_or_create_from_omniauth(auth_hash)
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Signed in!"
    else
      redirect_to root_url, alert: "Authentification failed!"
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    redirect_to root_url, notice: "Sucessfully logged out!"
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end
end