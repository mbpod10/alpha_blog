class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_admin, except: [:index, :show, :destroy]
  before_action :category_params, only:[:create]
  
  
  def show
    @articles = set_category.articles
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "'#{@category.name}' Successfully Created"
      redirect_to @category
     else
       render 'new'
     end
  end

  def destroy    
    @category.destroy
    flash[:notice] = "'#{@category.name}' Deleted!"
    redirect_to categories_path
  end


private
  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
     if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only Admin Can Perform That Action"
      redirect_to categories_path
     end
  end

end