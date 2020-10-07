class Party < ApplicationRecord
  belongs_to :movie

  validates :party_date, presence: true
  validates :start_time, presence: true
end
