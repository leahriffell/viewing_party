class User < ApplicationRecord
  has_secure_password

  has_many :party_users, dependent: :destroy
  has_many :parties, through: :party_users
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true

  def any_parties?
    !party_users.empty?
  end

  def party_status(party_id)
    party_users.where(party_id: party_id).pluck(:attendee_type).first
  end

  def friends?
    !friends.empty?
  end

  def add_friend(new_friend)
    Friendship.create(user_id: id, friend_id: new_friend.id)
    Friendship.create(user_id: new_friend.id, friend_id: id)
  end

  def friends_with?(friend)
    # friends.includes(friend) error when using AR method 
    friends.include?(friend)
  end
end
