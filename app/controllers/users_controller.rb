class UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :show, :destroy] 
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)   
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit  
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your Profile Was Successfully Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
     session[:user_id] = @user.id
     flash[:notice] = "Welcome To The Alpha Blog, #{@user.username} Successfully Created"
     redirect_to @user
    else
      render 'new'
    end    
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and Articles Successfully Delete"
    redirect_to articles_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You Can Only Edit Or Delete Your Own Account!"
      redirect_to @user
    end
  end

end