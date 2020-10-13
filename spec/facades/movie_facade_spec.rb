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

    it 'returns movie detail objects' do
        VCR.use_cassette('show_movie_details') do
            movies = MovieFacade.movie_details(278)

            expect(movies).to be_a(MovieCreator)
            expect(movies.genres).to be_an(Array)
            expect(movies.release_date).to be_a(String)
            expect(movies.runtime).to be_an(Integer)
            expect(movies.title).to be_a(String)
            expect(movies.vote_average).to be_a(Float)
        end
    end

    it 'returns a movie cast object' do
        VCR.use_cassette('show_movie_cast') do
            cast = MovieFacade.movie_cast(278)

            expect(cast).to be_a(MovieCreator)
            expect(cast).to be_an(Array)
            expect(cast.first).to be_a(Hash)
        end
    end

    it 'returns a movie reviews object' do
        VCR.use_cassette('show_movie_reviews') do
            reviews = MovieFacade.movie_reviews(278)

            expect(reviews).to be_a(MovieCreator)
        end
    end    
end