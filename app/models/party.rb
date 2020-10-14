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

  def invitees
    user_relation = users.joins("LEFT JOIN party_users AS p_u ON p_u.user_id = users.id").where("party_users.party_id = #{id} AND party_users.attendee_type = 1").distinct

    user_relation.map do |relation|
      relation
    end 
  end
end
