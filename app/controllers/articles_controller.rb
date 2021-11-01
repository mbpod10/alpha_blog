
class ArticlesController < ApplicationController
  def show  
    @article = Article.find(params[:id])   
  end

  def index    
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id]) 
  end

# BE WEARY OF ARTICLE MODEL VALIDATIONS
# ARTICLE WILL NOT BE CREATED IF DOES 
# NOT MEET MIN/MAX CONSTRAINTS
  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to @article
    else  
      render 'new'     
    end
  end

  def update
    @article = Article.find(params[:id]) 
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article #{params[:id].to_s} Was Updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

end
