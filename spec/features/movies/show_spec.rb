require 'rails_helper'

RSpec.describe 'Movies detail page' do
  describe 'As an authenticated user, when I visit a movies detail page, I see' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can see a movie's title" do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        expect(page).to have_content('Casino')
      end
    end

    it 'I see a button to create a viewing party' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        expect(page).to have_button('Create Viewing Party')
      end
    end

    it 'When I click create a viewing party, I am taken to the new event page' do
      VCR.use_cassette('show_movie_details') do
        visit(movie_show_path('524'))
        click_button('Create Viewing Party')
        expect(current_path).to eq(party_create_path)
      end
    end
  end
end
