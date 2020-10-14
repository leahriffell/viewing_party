class Party < ApplicationRecord
  belongs_to :movie
  has_many :party_users, dependent: :destroy
  has_many :users, through: :party_users

  validates :party_date, presence: true
  validates :start_time, presence: true

  def invite(user_ids)
    user_ids.each do |user_id|
      if user_id.length != 0
        users << User.find(user_id)
      end
    end
  end
end
