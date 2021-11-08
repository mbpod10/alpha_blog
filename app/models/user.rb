class User < ApplicationRecord
  has_many :articles
  VALID_EMAIL_REGEX = /\A\S+@.+\.\S+\z/
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            length:{minimum: 3, maxium: 25, message:"Username Must Be At Least 3 Characters and Less Than 26"}
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX, message: "Email Invalid"  },
            uniqueness: { case_sensitive: false, message: "Email Registered With Existing User" },
            length: { maximum: 105 }
end