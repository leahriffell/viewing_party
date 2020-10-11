class PartiesController < ApplicationController
  before_action :require_user

  def new
    response = conn.get("3/movie/#{params[:movie_id]}?api_key=#{movies_api_key}")
    @movie = JSON.parse(response.body, symbolize_names: true)
    @party = Party.new
  end

  def create
    if Movie.exists?(party_params[:movie_id])
      movie = Movie.find(party_params[:movie_id])
    else
      movie = Movie.create(id: party_params[:movie_id], title: params[:party][:movie_title])
    end
    party = Party.create(party_params)
    if party.save
      party.party_users.create(user_id: current_user.id, attendee_type: 0)
      redirect_to dashboard_path
    else 
      flash[:error] = party.errors.full_messages.to_sentence
      redirect_to new_party_path(movie_id: movie.id)
    end
  end

  private 

  def party_params
    params.require(:party).permit(:duration, :party_date, :start_time, :movie_id)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org')
  end

  def movies_api_key
    ENV['MOVIES_API_KEY']
  end
end
