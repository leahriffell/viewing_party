require 'rails_helper'

RSpec.describe 'Movies page' do
  describe 'As a authenticated user' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'when I type movies_path in browser, I am defaulted to being shown top movies' do
      # I don't think this test is really testing anything unless we assert that it includes a certain title / ranking / etc.
      VCR.use_cassette('top_movies') do
        visit movies_path

        expect(current_path).to eq(movies_path)
        expect(page).to have_content('Top Movies')
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
            VCR.use_cassette('show_movie_details') do
              #NOTE: I think this error may be because 'Casino' does not appear on top movies page?
              page.find('.title').click
              expect(page).to have_button('Create Viewing Party for Movie')
            end
          end
        end
      end
    end

    describe 'when I searched by keyword' do
      it 'I can see information about each movie and link to show page' do
        VCR.use_cassette('single_keyword_search') do
          visit movies_path

          expect(current_path).to eq(movies_path)
          expect(page).to have_content('Search Results')

          within(first('.movie')) do
            expect(page).to have_css('.title')
            expect(page).to have_css('.vote_avg')
            page.find('.title').click
            VCR.use_cassette('show_movie_details') do
              save_and_open_page
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
