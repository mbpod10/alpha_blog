
class ArticlesController < ApplicationController
  def show  
    @article = Article.find(params[:id])   
  end

  def index    
    @articles = Article.all
  end

  def new

  end

# BE WEARY OF ARTICLE MODEL VALIDATIONS
# ARTICLE WILL NOT BE CREATED IF DOES 
# NOT MEET MIN/MAX CONSTRAINTS
  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    @article.save
    redirect_to article_path(@article)
  end

end
