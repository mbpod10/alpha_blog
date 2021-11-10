class SessionsController < ApplicationController
  before_action :get_credentials, only:[:create]
  
  def new
  end

  def create    
    if User.where(email: get_credentials[:email]).exists?
      flash[:notice] = "#{get_credentials[:email]} Exists In Database!"
      user = User.where(email: get_credentials[:email]).first
      puts user.username
      puts user.email
      puts user.password
      render 'new'
    else        
      flash[:notice] = "#{get_credentials[:email]} Does Not Exist In Database!"
      render 'new'
    end
  end

  def destroy
  end

  private
  def get_credentials
    params.require(:session).permit(:email, :password)
  end

end