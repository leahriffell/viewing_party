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
    cast[:cast][0..9].map do |cast|
      "#{cast[:name]} as #{cast[:character]}"
    end
  end

  def review_count(reviews)
    reviews.count
  end

  def display_reviews(review_array)
    reviews = review_array.map do |review|
      "Author: #{review[:author]}\n\nURL: #{review[:url]}\n\nReview: #{review[:content]}"
    end
  end
end
