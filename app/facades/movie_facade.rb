class MovieFacade
  def self.get_movie_details(id)
    movie = movie_details(id)
    movie.cast = movie_cast(id)
    movie.reviews = movie_reviews(id)
    movie
  end

  def self.keyword_search(keywords)
    moviespg1 = MovieService.keyword_search(1, keywords)[:results]
    movies1 = moviespg1.map { |movie_data| MovieDetails.new(movie_data) } unless moviespg1.nil?
    moviespg2 = MovieService.keyword_search(2, keywords)[:results]
    movies2 = moviespg2.map { |movie_data| MovieDetails.new(movie_data) } unless moviespg2.nil?
    
    format_object_array(movies1, movies2)
  end

  def self.top_movies
    movies1 = MovieService.top_movies(1)[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
    movies2 = MovieService.top_movies(2)[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
    movies1.concat(movies2).flatten
  end

  def self.trending_movies
    trending = MovieService.trending_movies[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
  end

  private_class_method

  def self.movie_details(id)
    movie_details = MovieService.movie_details(id)
    MovieDetails.new(movie_details)
  end

  def self.movie_cast(id)
    MovieService.movie_cast(id)[:cast][0..9].map do |cast_data|
      CastDetails.new(cast_data)
    end
  end

  def self.movie_reviews(id)
    MovieService.movie_reviews(id)[:results].map do |review_data|
      ReviewDetails.new(review_data)
    end
  end

  def self.format_object_array(movies1, movies2)
    if movies1.empty? && movies2.empty?
      nil
    elsif movies2.empty?
      movies1
    else
      movies1.concat(movies2).flatten
    end
  end
end
