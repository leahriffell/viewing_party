class Party < ApplicationRecord
  belongs_to :movie

  validates :party_date
  validates :start_time
end
