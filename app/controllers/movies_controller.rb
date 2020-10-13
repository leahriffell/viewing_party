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
    show_response = movie_show_endpoint
    cast_response = movie_cast_endpoint
    review_response = movie_review_endpoint
    @movie_object = Movie.new
    @movie = parse(show_response)
    @movie_cast = parse(cast_response)
    @movie_review = parse(review_response)
  end

  def fetch_movies(request_type)
    if request_type == 'top'
      @movies = MovieFacade.top_movies
    else
      @movies = MovieFacade.keyword_search(params[:keyword_search])
    end
  end

  private

  def language(language)
    "language=#{language}"
  end

  def exclude_adult
    'include_adult=false'
  end

  def movies_api_key
    ENV['MOVIES_API_KEY']
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org")
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def movie_show_endpoint
    conn.get("3/movie/#{params[:id]}?api_key=#{movies_api_key}")
  end

  def movie_cast_endpoint
    conn.get("3/movie/#{params[:id]}/credits?api_key=#{movies_api_key}")
  end

  def movie_review_endpoint
    conn.get("3/movie/#{params[:id]}/reviews?api_key=#{movies_api_key}&#{language('en-US')}")
  end
end
