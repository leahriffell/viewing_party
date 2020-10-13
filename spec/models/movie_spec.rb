require 'rails_helper'

describe Movie, type: :model do
  describe 'relationships' do
    it { should have_many :parties }
  end

  describe 'instance methods' do
    before :each do
      @movie = Movie.new
    end
    xit 'can display the release year' do
      VCR.use_cassette('show_movie_details') do
        expect(@movie.release_year('10-10-2020')).to eq(2020)
      end
    end

    xit 'can display genres' do
      VCR.use_cassette('show_movie_details') do
        genre_array = [{"id": 35,"name": "Comedy"}, {"id": 18,"name": "Drama"}]
        expect(@movie.display_genres(genre_array)).to eq(["Comedy", "Drama"])
      end
    end

    xit 'can display runtime in hours and minutes' do
      VCR.use_cassette('show_movie_details') do
        expect(@movie.total_runtime(179)).to eq('2h 59m')
      end
    end

    xit 'can display the first 10 cast names and characters' do
      url = "https://api.themoviedb.org/3/movie/524/credits?api_key=#{ENV['MOVIES_API_KEY']}"
      json_response = File.read('spec/fixtures/show_movie_cast.json')
      stub_request(:get, url).to_return(status: 200, body: json_response)
      expect(@movie.first_10_cast(json_response)).to eq('aaaa')
    end

    xit 'can count the total number of reviews' do
      VCR.use_cassette('show_movie_details') do

      end
    end

    xit 'can display the review author, url, and body' do
      VCR.use_cassette('show_movie_details') do

      end
    end
  end
end
