require 'rails_helper'

RSpec.describe MovieService do
  it 'can fetch top 40 movies' do
    VCR.use_cassette('top_movies') do
      search_results = MovieService.top_movies(1)
      
      expect(search_results).to be_a(Hash)
      expect(search_results).to have_key :results

      results = search_results[:results]
      expect(results).to be_an(Array)

      first_result = results.first
      expect(first_result).to have_key :title
      expect(first_result[:title]).to be_a(String)

      expect(first_result).to have_key :vote_average
      expect(first_result[:vote_average]).to be_a(Float)
    end
  end

  it 'can fetch keyword search movies' do
    VCR.use_cassette('single_keyword_search') do
      search_results = MovieService.keyword_search(1, 'dog')
      
      expect(search_results).to be_a(Hash)
      expect(search_results).to have_key :results

      results = search_results[:results]
      expect(results).to be_an(Array)

      first_result = results.first
      expect(first_result).to have_key :title
      expect(first_result[:title]).to be_a(String)

      expect(first_result).to have_key :vote_average
      expect(first_result[:vote_average]).to be_a(Float)
    end
  end

  it 'can fetch movie details' do
    VCR.use_cassette('show_movie_details') do
      movie = MovieService.movie_details(524)
      expect(movie).to be_a(Hash)

      expect(movie).to have_key :genres
      expect(movie[:genres]).to be_an(Array)

      expect(movie).to have_key :overview
      expect(movie[:overview]).to be_a(String)

      expect(movie).to have_key :release_date
      expect(movie[:release_date]).to be_a(String)

      expect(movie).to have_key :runtime
      expect(movie[:runtime]).to be_an(Integer)

      expect(movie).to have_key :title
      expect(movie[:title]).to be_a(String)

      expect(movie).to have_key :vote_average
      expect(movie[:vote_average]).to be_a(Float)
    end
  end

  it 'can fetch cast details' do
    VCR.use_cassette('show_cast_details') do
      cast = MovieService.movie_cast(524)
      results = cast[:cast]
      expect(cast).to be_a(Hash)
      expect(results).to be_an(Array)

      expect(results.first).to have_key :character
      expect(results.first[:character]).to be_a(String)

      expect(results.first).to have_key :name
      expect(results.first[:name]).to be_a(String)
    end
  end

  it 'can fetch review details' do
    VCR.use_cassette('show_review_details') do
      reviews = MovieService.movie_reviews(524)
      results = reviews[:results]
      expect(reviews).to be_a(Hash)
      expect(results).to be_an(Array)

      expect(results.first).to have_key :author
      expect(results.first[:author]).to be_a(String)

      expect(results.first).to have_key :url
      expect(results.first[:url]).to be_a(String)

      expect(results.first).to have_key :content
      expect(results.first[:content]).to be_a(String)
    end
  end

  it 'can fetch recommended movies' do
    VCR.use_cassette('show_recommendation_details') do
      recommendations = MovieService.movie_recommendations(524)
      results = recommendations[:results]
      expect(recommendations).to be_a(Hash)
      expect(results).to be_an(Array)

      expect(results.first).to have_key :title
      expect(results.first[:title]).to be_a(String)
    end
  end
end
