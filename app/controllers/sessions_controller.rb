class SessionsController < ApplicationController
  before_action :get_credentials, only:[:create]
  
  def new
  end

  def create
    user = User.find_by(email: get_credentials[:email].downcase)
    if user
      if user.authenticate(get_credentials[:password])
        session[:user_id] = user.id
        flash[:notice] = "#{get_credentials[:email]} Logged In"
        redirect_to user
      else
        flash.now[:alert] = "Incorrect Password"
        render 'new'
      end
    else
      flash.now[:alert] = "Email Not Associated With User" 
      render 'new'
    end
  end

  def destroy
    flash[:notice] = "#{session[:user_id]} User Logged Out"
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def get_credentials
    params.require(:session).permit(:email, :password)
  end

end