require 'date'

class Movie < ApplicationRecord
  has_many :parties, dependent: :destroy

  def release_year(release_date)
    if release_date != ''
      Date.parse(release_date).year
    else
      return 'n/a'
    end
  end

  def display_genres(genre_array)
    genre_array.map do |genre|
      genre[:name]
    end
  end

  def total_runtime(runtime)
    hours = runtime / 60
    remaining = runtime % 60
    "#{hours}h #{remaining}m"
  end

  def first_10_cast(cast)
    actors = cast[:cast][0..9].map do |cast|
      cast[:name]
    end
  end
end
