class MoviesController < ApplicationController
  def index
    if params[:top_40]
      top_40
    else 
      keyword_search
    end
  end

  def top_40
    response_1 = conn.get("3/discover/movie?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false&page=1")
    
    response_2 = conn.get("3/discover/movie?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false&page=2")
    
    json_1 = JSON.parse(response_1.body, symbolize_names: true)
    json_2 = JSON.parse(response_2.body, symbolize_names: true)

    @movies_1 = json_1[:results]
    @movies_2 = json_2[:results]
  end
  
  def keyword_search
    response_1 = conn.get("3/search/movie?api_key=#{ENV['MOVIES_API_KEY']}&query=#{params[:keyword_search]}&page=1")
    
    response_2 = conn.get("3/search/movie?api_key=#{ENV['MOVIES_API_KEY']}&query=#{params[:keyword_search]}&page=2")
    
    json_1 = JSON.parse(response_1.body, symbolize_names: true)
    json_2 = JSON.parse(response_2.body, symbolize_names: true)

    @movies_1 = json_1[:results]
    @movies_2 = json_2[:results]
  end

  private 

  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['X-API-Key'] = ENV['MOVIES_API_KEY']
    end
  end
end
