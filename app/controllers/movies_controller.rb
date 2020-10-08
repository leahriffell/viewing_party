class MoviesController < ApplicationController
  def index
    if params[:top]
      fetch_movies('top')
    else 
      fetch_movies('search')
    end
  end

  def fetch_movies(request_type)
    if request_type == 'top'
      response_1 = top_40_endpoint("1")
      response_2 = top_40_endpoint("2")
    else 
      response_1 = top_40_endpoint("1")
      response_2 = top_40_endpoint("2")
    end
    json_1 = parse(response_1)
    json_2 = parse(response_2)

    @movies_1 = json_1[:results]
    @movies_2 = json_2[:results]
  end

  private 

  def conn
    Faraday.new(url: 'https://api.themoviedb.org')
  end

  def top_40_endpoint(page_num)
    conn.get("3/discover/movie?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false&page=#{page_num}")
  end

  def keyword_search_endpoint(page_num)
    conn.get("3/search/movie?api_key=#{ENV['MOVIES_API_KEY']}&query=#{params[:keyword_search]}&page=#{page_num}")
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
