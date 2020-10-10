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
    show_response = conn.get("3/movie/#{params[:id]}?api_key=#{movies_api_key}")
    cast_response = conn.get("3/movie/#{params[:id]}/credits?api_key=#{movies_api_key}")
    @movie_object = Movie.new
    @movie = parse(show_response)
    @movie_cast = parse(cast_response)
  end

  def fetch_movies(request_type)
    if request_type == 'top'
      response1 = top_movies_endpoint(1)
      response2 = top_movies_endpoint(2)
    else
      response1 = keyword_search_endpoint(1)
      response2 = keyword_search_endpoint(2)
    end
    json1 = parse(response1)
    json2 = parse(response2)
    @movies1 = json1[:results]
    @movies2 = json2[:results]
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

  def top_movies_endpoint(page_num)
    sort_by = 'vote_average.desc'
    conn.get("3/discover/movie?api_key=#{movies_api_key}&#{language('en-US')}&sort_by=#{sort_by}&#{exclude_adult}&page=#{page_num}")
  end

  def keyword_search_endpoint(page_num)
    conn.get("3/search/movie?api_key=#{movies_api_key}&#{language('en-US')}&query=#{params[:keyword_search]}&#{exclude_adult}&page=#{page_num}")
  end

  def movie_show_endpoint
    conn.get("3/movie/#{params[:id]}?api_key=#{movies_api_key}")
  end

  def movie_cast_endpoint
    conn.get("https://api.themoviedb.org/3/movie/#{params[:id]}/credits?api_key=#{movies_api_key}")
  end
end
