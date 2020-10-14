class MovieFacade

# def self.top_movies_endpoint(page_num)
#     sort_by = 'vote_average.desc'
#     conn.get("3/discover/movie?api_key=#{movies_api_key}&#{language('en-US')}&sort_by=#{sort_by}&#{exclude_adult}&page=#{page_num}&vote_count.gte=300")
# end

# def self.keyword_search_endpoint(page_num, keywords)
#     conn.get("3/search/movie?api_key=#{movies_api_key}&#{language('en-US')}&#{exclude_adult}&page=#{page_num}&query=#{keywords}")
# end

# def self.movie_show_endpoint(id)
#     conn.get("3/movie/#{id}?api_key=#{movies_api_key}")
# end

# def self.movie_cast_endpoint(id)
#     conn.get("3/movie/#{id}/credits?api_key=#{movies_api_key}")
# end

# def self.movie_review_endpoint(id)
#     conn.get("3/movie/#{id}/reviews?api_key=#{movies_api_key}&#{language('en-US')}")
# end

def self.keyword_search(keywords)
  # if MovieService.keyword_search(1, keywords)[:status]
    # movies1 = MovieService.keyword_search(1, keywords)[:results].map do |movie_data|
    #   MovieDetails.new(movie_data)
    # end
  # else
    movies1 = MovieService.keyword_search(1, keywords)[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
    movies2 = MovieService.keyword_search(2, keywords)[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
  # end
  (movies1.concat(movies2)).flatten
end

  def self.top_movies
    movies1 = MovieService.top_movies(1)[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
    movies2 = MovieService.top_movies(2)[:results].map do |movie_data|
      MovieDetails.new(movie_data)
    end
    (movies1.concat(movies2)).flatten
  end

  def self.get_movie_details(id)
    movie = movie_details(id)
    movie.cast = movie_cast(id)
    movie.reviews = movie_reviews(id)
    movie
  end

  private

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
end

#     def self.language(language)
#         "language=#{language}"
#     end

#     def self.exclude_adult
#         'include_adult=false'
#     end

#     def self.movies_api_key
#         ENV['MOVIES_API_KEY']
#     end

#     def self.conn
#         Faraday.new(url: "https://api.themoviedb.org")
#     end

#     def self.parse(response)
#         JSON.parse(response.body, symbolize_names: true)
#     end
