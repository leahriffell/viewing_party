require 'rails_helper'

RSpec.describe 'Movies page' do
  describe 'As a authenticated user' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'when I type movies_path in browser, I am defaulted to being shown top movies' do
      VCR.use_cassette('top_movies') do
        visit movies_path

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Top Movies')
      end
    end

    it 'when I click button to find top movies, I am redirected to movies page with top movies' do
      VCR.use_cassette('top_movies') do
        visit discover_path

        click_button('Find Top Rated Movies')

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Top Movies')
      end
    end

    it "when I input search keyword and click 'Find Movies', I am redirected to movies page with search results" do
      VCR.use_cassette('single_keyword_search') do
        visit discover_path

        fill_in :keyword_search, with: 'dogs'
        click_button('Find Movies')
        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Search Results')
      end
    end

    describe 'when I searched for top movies' do
      it 'I can see information about each movie and link to show page' do
        VCR.use_cassette('top_movies') do
          visit movies_path

          expect(current_path).to eq(movies_path)
          expect(page).to have_content('Top Movies')

          within(first('.movie')) do
            expect(page).to have_css('.title')
            expect(page).to have_css('.vote_avg')
            VCR.use_cassette('top_result_first_movie_details') do
              page.find('.title').click
              rescue Selenium::WebDriver::Error::StaleElementReferenceError
                sleep 1
              retry
              expect(page).to have_button('Create Viewing Party for Movie')
            end
          end
        end
      end
    end

    describe 'when I searched by keyword' do
      it 'I can see information about each movie and link to show page' do
        VCR.use_cassette('single_keyword_search', allow_playback_repeats: true) do
          visit discover_path
          fill_in :keyword_search, with: 'dog'
          click_button('Find Movies')

          expect(current_path).to eq(movies_path)
          expect(page).to have_content('Search Results')

          within(first('.movie')) do
            expect(page).to have_css('.title')
            expect(page).to have_css('.vote_avg')
            page.find('.title').click
            VCR.use_cassette('dog_search_first_movie_details', allow_playback_repeats: true) do
              rescue Selenium::WebDriver::Error::StaleElementReferenceError
                sleep 1
              retry
              expect(page).to have_button('Create Viewing Party for Movie')
            end
          end
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
    end
  end

  describe 'As an unauthenticated user' do
    it 'When I manually type in /movies, I see an error or warning' do
      visit movies_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
