require 'rails_helper'

RSpec.describe 'Movies page' do
  describe 'As a authenticated user' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "when I type movies_path in browser, I am defaulted to being shown top movies" do
      VCR.use_cassette('top_movies') do

        visit movies_path

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Top Movies')
      end
    end

    describe 'I am shown search results even when' do 
      it 'search terms include 2 words' do
        VCR.use_cassette('two_keyword_search') do
          visit discover_path

          fill_in :keyword_search, with: 'toy story'
          click_button('Find Movies')

          expect(current_path).to eq(movies_path)
          expect(page).to have_content('Search Results')
        end
      end

      it 'search terms return 20 or less movie results' do
        VCR.use_cassette('one_page_results') do
          visit discover_path

          fill_in :keyword_search, with: 'star wars'
          click_button('Find Movies')

          expect(current_path).to eq(movies_path)
          expect(page).to have_content('Search Results')
        end
      end
    end

  #   it 'when I click button to find top movies, I am redirected to movies page with top movies' do
  #     VCR.use_cassette('top_movies') do
  #       visit discover_path

  #       click_button('Find Top Rated Movies')

  #       expect(current_path).to eq(movies_path)
  #       expect(page).to have_content('Top Movies')
  #     end
  #   end
  end

  describe 'As an unauthenticated user' do
    it 'When I manually type in /movies, I see an error or warning' do
      visit movies_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end