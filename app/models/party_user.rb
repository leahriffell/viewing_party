class PartyUser < ApplicationRecord
  belongs_to :user
  belongs_to :party

  validates :attendee_type, presence: true

  enum attendee_type: { 'host': 0, 'guest': 1 }
end
