require 'rails_helper'

RSpec.describe 'Movie' do
    it 'exists' do
        attr = {
            title: 'Nic Eats a Hamburger',
            vote_average: 10,
            release_date: '2020-10-01',
            genres: [{id: 80, name: 'Crime'}, {id: 99, name: 'Drama'}],
            runtime: 179,
            overview: 'Award winning movie about a guy eating a hamburger'
        }
        movie1 = MovieCreator.new(attr)

        expect(movie1).to be_a(MovieCreator)
        expect(movie1.title).to eq('Nic Eats a Hamburger')
        expect(movie1.vote_average).to eq(10)
        expect(movie1.release_date).to eq('2020-10-01')
        expect(movie1.genres).to eq([{id: 80, name: 'Crime'}, {id: 99, name: 'Drama'}])
        expect(movie1.runtime).to eq(179)
        expect(movie1.overview).to eq('Award winning movie about a guy eating a hamburger')
    end

  describe 'instance methods' do
    before :each do
      @movie = MovieCreator.new
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

    it 'can display the first 10 cast names and characters' do
      url = "https://api.themoviedb.org/3/movie/524/credits?api_key=#{ENV['MOVIES_API_KEY']}"
      json_response = File.read('spec/fixtures/show_movie_cast.json')
      require 'pry'; binding.pry
      stub_request(:get, url).to_return(status: 200, body: json_response)
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