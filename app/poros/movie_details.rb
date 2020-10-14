class MovieDetails
  attr_reader :title,
              :vote_average,
              :release_date,
              :genres,
              :runtime,
              :overview,
              :id
  attr_accessor :cast,
                :reviews

  def initialize(attr)
    @title = attr[:title]
    @vote_average = attr[:vote_average]
    @release_date = attr[:release_date]
    @genres = attr[:genres]
    @runtime = attr[:runtime]
    @overview = attr[:overview]
    @id = attr[:id]
    @cast = []
    @reviews = []
  end

  def release_year(date)
    if no_release_date?(date)
      nil
    else
      Date.parse(date).year
    end
  end

  def total_runtime(runtime)
    if runtime.nil?
      0
    else
      hours = runtime / 60
      remaining = runtime % 60
      "#{hours}h #{remaining}m"
    end
  end

  def display_genres(genre_array)
    genre_array.map do |genre|
      genre[:name]
    end
  end

  private

  def no_release_date?(date)
    date.empty?
  end
end
