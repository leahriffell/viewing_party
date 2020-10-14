require 'rails_helper'

RSpec.describe 'Movie Facade' do
  it 'returns a list of top movie objects' do
    VCR.use_cassette('top_movies') do
      movies = MovieFacade.top_movies

      expect(movies).to be_an(Array)
      expect(movies.first).to be_a(MovieDetails)
      expect(movies.first.title).to be_a(String)
      expect(movies.first.vote_average).to be_an(Float)
      end
  end

  it 'retuns a list of searched movie objects' do
    VCR.use_cassette('single_keyword_search') do
      movies = MovieFacade.keyword_search('dog')

      expect(movies).to be_an(Array)
      expect(movies.first).to be_a(MovieDetails)
      expect(movies.first.title).to be_a(String)
      expect(movies.first.vote_average).to be_an(Float)
    end
  end

  it 'returns movie detail objects' do
    VCR.use_cassette('show_movie_details') do
      movies = MovieFacade.get_movie_details(278)

      expect(movies).to be_a(MovieDetails)
      expect(movies.cast).to be_an(Array)
      expect(movies.cast.first).to be_a(CastDetails)
      expect(movies.cast.first.character).to be_a(String)
      expect(movies.cast.first.name).to be_a(String)
      expect(movies.genres).to be_an(Array)
      expect(movies.genres.first).to be_an(Hash)
      expect(movies.overview).to be_a(String)
      expect(movies.release_date).to be_a(String)
      expect(movies.reviews).to be_an(Array)
      expect(movies.runtime).to be_an(Integer)
      expect(movies.title).to be_a(String)
      expect(movies.vote_average).to be_a(Float)
    end
  end
end