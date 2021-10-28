# require 'debugger'
class ArticlesController < ApplicationController
  def show
    # logger.debug
    @article = Article.find(params[:id])   
  end

  def index    
    @articles = Article.all
    puts @articles
  end
end
