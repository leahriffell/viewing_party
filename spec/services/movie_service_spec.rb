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
end