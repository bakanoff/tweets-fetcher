class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = "Sucessfully logged out!"
    end
    redirect_to root_url
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end
end