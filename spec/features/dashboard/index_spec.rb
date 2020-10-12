require 'rails_helper'

RSpec.describe 'Discover page' do
  describe 'As a authenticated user' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Can click a button to discover movies page' do
      click_button('Discover Movies')

      expect(current_path).to eq(movies_path)
    end
  end

  describe 'As an unauthenticated user' do
    it 'When manually type in /dashboard, I see an error or warning' do
      visit discover_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end