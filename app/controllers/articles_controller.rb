class ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update, :destroy]
  # require_user method from  /app/controllers/application_controller.rb
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show      
  end

  def index    
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit     
  end

  # current_user is from /app/controllers/application_controller.rb
  def create   
    @article = Article.new(article_params)
    check_category_tags()
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to @article
    else  
      render 'new'     
    end
  end

  def update     
    if @article.update(article_params)
      flash[:notice] = "Article Titled '#{@article.title}' Was Updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy    
    @article.destroy
    redirect_to articles_path
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def check_category_tags   
    str = article_params[:description].split(" ").each { |c|
      if c[0] == "#"
        word = (c[1...]).titleize     
        if Category.exists?(name: word)         
            @article.categories << Category.where(name: word)
        else
          new_category = Category.create(name: word)
          if new_category.save
            @article.categories << new_category
          end
        end
      end
    }   
  end
  

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You Can Only Edit Or Delete Your Own Article!"
      redirect_to @article
    end
  end
  

end
