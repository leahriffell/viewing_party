require 'rails_helper'

RSpec.describe 'Movie Facade' do
    it 'returns a list of top movie objects' do
        VCR.use_cassette('top_movies') do
            movies = MovieFacade.top_movies

            expect(movies).to be_an(Array)
            expect(movies.first).to be_a(MovieCreator)
            expect(movies.first.title).to be_a(String)
            expect(movies.first.vote_average).to be_an(Float)
        end
    end

    it 'retuns a list of searched movie objects' do
        VCR.use_cassette('single_keyword_search') do
            movies = MovieFacade.keyword_search('dog')

            expect(movies).to be_an(Array)
            expect(movies.first).to be_a(MovieCreator)
            expect(movies.first.title).to be_a(String)
            expect(movies.first.vote_average).to be_an(Float)
        end
    end
end