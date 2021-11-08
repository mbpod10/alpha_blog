class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length:{minimum: 6, maxium: 100}
  validates :description, presence: true, length:{minimum: 10, maxium: 300}
end