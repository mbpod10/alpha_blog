class User < ApplicationRecord
  before_validation { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  VALID_EMAIL_REGEX = /\A\S+@.+\.\S+\z/
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            length:{minimum: 3, maxium: 25, message:"Must Be At Least 3 Characters and Less Than 26"}
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX, message: "Invalid"  },
            uniqueness: { case_sensitive: false, message: "Registered With Existing User" },
            length: { maximum: 105 }
  has_secure_password
end