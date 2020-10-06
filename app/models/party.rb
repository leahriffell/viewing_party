class Party < ApplicationRecord

  belongs_to :movie

  validates_presence_of :party_date
  validates_presence_of :start_time
end
