class User < ApplicationRecord
  has_secure_password

  has_many :party_users
  has_many :parties, through: :party_users
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true

  def any_parties?
    !party_users.empty?
  end

  def party_status(party_id)
    self.party_users.where(party_id: party_id).pluck(:attendee_type).first
  end
end
