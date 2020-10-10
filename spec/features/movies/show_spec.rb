require 'rails_helper'

RSpec.describe 'Movies detail page' do
  describe 'As an authenticated user, when I visit a movies detail page' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see a button to create a viewing party' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        expect(page).to have_button('Create Viewing Party')
      end
    end

    xit 'I click create a viewing party, I am taken to the new event page' do
      VCR.use_cassette('show_movie_details') do
        # this test will need to be reactiviated once we have the party page working
        visit(movie_show_path('524'))
        click_button('Create Viewing Party')
        expect(current_path).to eq(party_create_path)
      end
    end

    it 'I see the movies title' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        expect(page).to have_content('Casino')
      end
    end

    xit 'I see the movies vote average' do

    end

    xit 'I see the movies runtime in hours and minutes' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        within '#runtime' do
          expect(page).to have_content('2h 59m')
        end
      end
    end

    it 'I see the movies genre(s)' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        within '#genres' do
          expect(page).to have_content('Crime')
        end
      end
    end

    it 'I see the summary description' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        within '#overview' do
          expect(page).to have_content('In early-1970s Las Vegas, low-level mobster Sam')
        end
      end
    end

    xit 'I see a list of the first 10 cast members including their character and name' do

    end

    xit 'I see a count of the total number of reviews' do

    end

    xit 'I see for the reviews, each authors name and their information' do

    end
  end
end
