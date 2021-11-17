class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length:{minimum: 6, maxium: 100}
  validates :description, presence: true, length:{minimum: 10, maxium: 300}
  
  def self.search(query)
    if query
      articles = Article.where("description LIKE ?", "%#{query}%")
    else
      articles = Article.all
    end
  end

  def self.last_article
    articles = Article.last
  end
  
end
