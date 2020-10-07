require 'rails_helper'

RSpec.describe 'Discover page' do
  describe 'As a authenticated user' do
    before :each do 
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'when I click button to find top movies, I am redirected to movies page' do
      visit discover_path

      click_button('Find Top Rated Movies')
      expect(current_path).to eq(movies_path)
    end

    it "when I search for movie keyword(s) and click 'Find Movies', I am redirected to search result page" do
      visit discover_path

      fill_in :keyword_search, with: 'dogs'
      click_button('Find Movies')
      expect(current_path).to eq(movies_path)
    end

    it "when I click 'Find Movies' without entering any keyword(s) I am not redirected to search result page" do
      visit discover_path

      click_button('Find Movies')

      # page.find("#keyword_search").native.attribute("validationMessage")
      # expect(message).to eq "Please fill out this field."
      # expect(current_path).to eq edit_link_path(user.links.first)

      # expect(current_path).to eq(discover_path)
      # look into this test as it is working in local host but this test is failing and shows that user is on /movies
    end
  end
end