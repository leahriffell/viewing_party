class PartyUser < ApplicationRecord

  belongs_to :user
  belongs_to :party

  validates_presence_of :attendee_type

  enum role: ['host', 'guest']
end