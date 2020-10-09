require 'rails_helper'

RSpec.describe 'Discover page' do
  describe 'As a authenticated user' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'when I click button to find top movies, I am redirected to movies page' do
      VCR.use_cassette('top_movies') do
        visit discover_path

        click_button('Find Top Rated Movies')

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Top Movies')
      end
    end

    it "when I input 1 search keyword and click 'Find Movies', I am redirected to search result page" do
      VCR.use_cassette('single_keyword_search') do
        visit discover_path

        fill_in :keyword_search, with: 'dogs'
        click_button('Find Movies')
        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Search Results')
      end
    end

    it "when I input 2 search keyword(s) and click 'Find Movies', I am redirected to search result page" do
      VCR.use_cassette('two_keyword_search') do
        visit discover_path

        fill_in :keyword_search, with: 'toy story'
        click_button('Find Movies')

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Search Results')
      end
    end

    it "when I click 'Find Movies' without entering any keyword(s) I am not redirected to search result page" do
      visit discover_path

      click_button('Find Movies')

      expect(current_path).to eq(discover_path)
    end

    it "when I type movies_path in browser, I am shown the top movies" do
      VCR.use_cassette('top_movies') do

        visit movies_path

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Top Movies')
      end
    end
  end

  describe 'As an unauthenticated user' do
    it 'When manually type in /discover, I see an error or warning' do
      visit discover_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
