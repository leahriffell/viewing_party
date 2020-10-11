class Party < ApplicationRecord
  belongs_to :movie
  has_many :party_users, dependent: :destroy
  has_many :users, through: :party_users

  validates :party_date, presence: true
  validates :start_time, presence: true
end
