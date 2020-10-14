class MoviesController < ApplicationController
  before_action :require_user

  def index
    if params[:top_40] || !params[:top_40] && !params[:keyword_search]
      fetch_movies('top')
    elsif params[:keyword_search] != ''
      fetch_movies('search')
    else
      redirect_to discover_path
    end
  end

  def show
    @movie = MovieFacade.get_movie_details(params[:id])
    # @movie = MovieFacade.movie_details(params[:id])
    # @movie_cast = MovieFacade.movie_cast(params[:id])
    # @movie_reviews = MovieFacade.movie_reviews(params[:id])
  end

  def fetch_movies(request_type)
    if request_type == 'top'
      @movies = MovieFacade.top_movies
    else
      @movies = MovieFacade.keyword_search(params[:keyword_search])
    end
  end

  # private

  # def language(language)
  #   "language=#{language}"
  # end

  # def exclude_adult
  #   'include_adult=false'
  # end

  # def movies_api_key
  #   ENV['MOVIES_API_KEY']
  # end

  # def conn
  #   Faraday.new(url: "https://api.themoviedb.org")
  # end

  # def parse(response)
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end
