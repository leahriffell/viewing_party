require 'rails_helper'

RSpec.describe 'Create Viewing Party page' do
  describe 'As a authenticated user' do
    it 'Can view but not edit movie title' do
    end

    it 'Can see duration of party defaulted to runtime of movie' do 
      #in minutes
    end

    it 'Can create viewing party (without editing duration)' do
    end

    it 'Can create viewing party (with edit of duration)' do
    end
 
    it 'Cannot create viewing party when no date is entered' do
    end

    it 'Cannot create viewing party when no time is entered' do

    end
  end

  describe 'As an unauthenticated user' do
    it 'When manually type in /parties/new, I see an error or warning' do
      visit new_party_path
      
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end 
end
