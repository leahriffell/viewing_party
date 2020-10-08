class MoviesController < ApplicationController
  def index
    if params[:top_40]
      top_40
    else 
      keyword_search
    end
  end

  def top_40
    response_1 = top_40_endpoint("1")
    response_2 = top_40_endpoint("2")
    
    json_1 = parse(response_1)
    json_2 = parse(response_2)

    @movies_1 = json_1[:results]
    @movies_2 = json_2[:results]
  end
  
  def keyword_search
    response_1 = keyword_search_endpoint("1")
    response_2 = keyword_search_endpoint("2")
    
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
    conn.get("3/discover/movie?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false&page=#{page_num}")
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
