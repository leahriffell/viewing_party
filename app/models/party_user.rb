class PartyUser < ApplicationRecord
  belongs_to :user
  belongs_to :party

  validates :attendee_type

  enum role: { 'host': 0, 'guest': 1 }
end
