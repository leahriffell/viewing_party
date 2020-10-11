require 'rails_helper'

RSpec.describe 'Create Viewing Party page' do
  describe 'As a authenticated user' do
    before :each do
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette('show_movie_details') do
        visit movie_show_path('751702')
        click_button('Create Viewing Party')
      end
    end

    it 'Can view but not edit movie title' do
      expect(page).to have_content('Alien Contact: The Pascagoula UFO Encounter')
    end

    it 'Can see duration of party defaulted to runtime of movie' do 
      expect(find_field('party[duration]').value).to eq('75')
    end

    it 'Can create viewing party (without editing duration)' do
      fill_in 'party[party_date]', with: '10/10/2020'
      fill_in 'party[start_time]', with: '7:00 PM'
      click_button('Create Party')

      expect(current_path).to eq(dashboard_path)

      within(first(".party")) do
        expect(page).to have_content('Alien Contact: The Pascagoula UFO Encounter')
        expect(page).to have_content('October 10, 2020')
        expect(page).to have_content('7:00 PM')
        expect(page).to have_content('host')
      end
    end

    it 'Can create viewing party (with edit of duration)' do
      fill_in 'party[duration]', with: '100'
      fill_in 'party[party_date]', with: '11/11/2021'
      fill_in 'party[start_time]', with: '8:30 PM'
      click_button('Create Party')

      expect(current_path).to eq(dashboard_path)

      within(first(".party")) do
        expect(page).to have_content('Alien Contact: The Pascagoula UFO Encounter')
        expect(page).to have_content('November 11, 2021')
        expect(page).to have_content('8:30 PM')
        expect(page).to have_content('host')
      end
    end
 
    it 'Cannot create viewing party when no date is entered' do
      VCR.use_cassette('show_movie_details') do
        fill_in 'party[duration]', with: '100'
        fill_in 'party[start_time]', with: '7:00 PM'
        click_button('Create Party')
  
        expect(current_path).to eq(new_party_path)
        expect(page).to have_content("Party date can't be blank")
      end
    end

    it 'Cannot create viewing party when no time is entered' do
      VCR.use_cassette('show_movie_details') do
        fill_in 'party[duration]', with: '200'
        fill_in 'party[party_date]', with: '1/1/2021  '
        click_button('Create Party')

        expect(current_path).to eq(new_party_path)
        expect(page).to have_content("Start time can't be blank")
      end
    end

    it 'Cannot create viewing party when date and time are not entered' do
      VCR.use_cassette('show_movie_details') do
        click_button('Create Party')
  
        expect(current_path).to eq(new_party_path)
        expect(page).to have_content("Party date can't be blank and Start time can't be blank")
      end
    end

    it 'Cannot create viewing party when date in the past is entered' do
      VCR.use_cassette('show_movie_details') do
        click_button('Create Party')
  
        expect(current_path).to eq(new_party_path)
        fill_in 'party[party_date]', with: '1/1/1990'
        fill_in 'party[start_time]', with: '7:34 PM'
        expect(current_path).to eq(new_party_path)
      end
    end
  end

  describe 'As an unauthenticated user' do
    it 'When manually type in /parties/new, I see an error or warning' do
      visit new_party_path
      
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end 
end