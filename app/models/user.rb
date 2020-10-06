class User < ApplicationRecord

  has_secure_password

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
end
