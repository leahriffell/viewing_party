require 'rails_helper'

RSpec.describe 'Movies detail page' do
  describe 'As an authenticated user, when I visit a movies detail page, I see' do
    before :each do
      json_response = File.read('spec/fixtures/show_movie_details.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/524?api_key=4a1709ef1078c62c83463642867fb188").to_return(status: 200, body: json_response)

      @movie = JSON.parse(json_response, symbolize_names: true)

      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can see a movies title' do
      # VCR.use_cassette('show_movie_details') do
        visit(movie_show_path(@movie[:id]))
        expect(page).to have_content(@movie[:title])
      # end
    end
  end
end
