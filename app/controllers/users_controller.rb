class UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :show] 

  def show
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit  
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User ID #{params[:id].to_s} Was Updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
     flash[:notice] = "Welcome To The Alpha Blog, #{@user.username} Successfully Updated"
     redirect_to articles_path
    else
      render 'new'
    end
    
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end