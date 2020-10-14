require 'rails_helper'

RSpec.describe 'Create Viewing Party page' do
  describe 'As a authenticated user' do
    before :each do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @user3 = FactoryBot.create(:user)
      @user4 = FactoryBot.create(:user)

      @user1.add_friend(@user2)
      @user1.add_friend(@user3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      VCR.use_cassette('show_movie_details') do
        visit movie_path('751702')
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
      select 2020, :from => "party_party_date_1i"
      select 'October', :from => "party_party_date_2i"
      select 10, :from => "party_party_date_3i"
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
      select 2021, :from => "party_party_date_1i"
      select 'November', :from => "party_party_date_2i"
      select 11, :from => "party_party_date_3i"
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

    it 'Can create viewing party and invite a friend' do
      fill_in 'party[duration]', with: '300'
      select 2021, :from => "party_party_date_1i"
      select 'November', :from => "party_party_date_2i"
      select 12, :from => "party_party_date_3i"     
      fill_in 'party[start_time]', with: '9:30 PM'
      within("#party_party_users_#{@user2.id}") do 
        check
      end
      click_button('Create Party')

      within(first(".party")) do
        expect(page).to have_content('Alien Contact: The Pascagoula UFO Encounter')
        expect(page).to have_content('November 12, 2021')
        expect(page).to have_content('9:30 PM')
        expect(page).to have_content('host')
        expect(page).to have_content("#{@user2.email}")
      end
    end

    it 'Can create viewing party and invite multiple friends' do
      fill_in 'party[duration]', with: '100'
      select 2021, :from => "party_party_date_1i"
      select 'January', :from => "party_party_date_2i"
      select 11, :from => "party_party_date_3i"      
      fill_in 'party[start_time]', with: '8:30 PM'
      within("#party_party_users_#{@user2.id}") do 
        check
      end
      within("#party_party_users_#{@user3.id}") do 
        check
      end
      click_button('Create Party')

      within(first(".party")) do
        expect(page).to have_content('Alien Contact: The Pascagoula UFO Encounter')
        expect(page).to have_content('January 11, 2021')
        expect(page).to have_content('8:30 PM')
        expect(page).to have_content('host')
        expect(page).to have_content("#{@user2.email}")
        expect(page).to have_content("#{@user3.email}")
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
        select 2021, :from => "party_party_date_1i"
        select 'July', :from => "party_party_date_2i"
        select 4, :from => "party_party_date_3i"        
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

    xit 'Cannot create viewing party when date in the past is entered' do
      VCR.use_cassette('show_movie_details') do
        click_button('Create Party')

        expect(current_path).to eq(new_party_path)
        select 'November', :from => "party_party_date_2i"
        select 11, :from => "party_party_date_3i"
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
