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
  end

  def fetch_movies(request_type)
    if request_type == 'top'
      @movies = MovieFacade.top_movies
    else
      @movies = MovieFacade.keyword_search(params[:keyword_search])
    end
  end
end
