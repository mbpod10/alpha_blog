class Category < ApplicationRecord
  before_validation { self.name = name.titleize }
  validates :name, presence: true, length: {minimum: 3, maximum: 25}
  validates_uniqueness_of :name 
  has_many :article_categories
  has_many :articles, through: :article_categories
end