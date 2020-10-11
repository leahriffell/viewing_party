require 'rails_helper'

describe Movie, type: :model do
  describe 'relationships' do
    it { should have_many :parties }
  end

  describe 'instance methods' do
    before :each do
      @movie = Movie.new
    end
    it 'can display the release year' do
      VCR.use_cassette('show_movie_details') do
        expect(@movie.release_year('10-10-2020')).to eq(2020)
      end
    end

    it 'can display genres' do
      VCR.use_cassette('show_movie_details') do
        genre_array = [{"id": 35,"name": "Comedy"}, {"id": 18,"name": "Drama"}]
        expect(@movie.display_genres(genre_array)).to eq(["Comedy", "Drama"])
      end
    end

    it 'can display runtime in hours and minutes' do
      VCR.use_cassette('show_movie_details') do
        expect(@movie.total_runtime(179)).to eq('2h 59m')
      end
    end

    it 'can display the first 10 cast names and characters' do
      VCR.use_cassette('show_movie_details') do

      end
    end

    it 'can count the total number of reviews' do
      VCR.use_cassette('show_movie_details') do

      end
    end

    it 'can display the review author, url, and body' do
      VCR.use_cassette('show_movie_details') do

      end
    end
  end
end
