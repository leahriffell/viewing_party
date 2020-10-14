require 'rails_helper'

RSpec.describe 'Dashboard page' do
  describe 'As a authenticated user' do
    before :each do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @user3 = FactoryBot.create(:user)

      @movie = Movie.create!(id: 524, title: 'Casino')
      @party = FactoryBot.create(:party)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it 'Can click a button to discover movies page' do
      VCR.use_cassette('top_movies') do
        visit dashboard_path
        click_button('Discover Movies')

        expect(current_path).to eq(movies_path)
      end
    end

    it "If I have no friends, I see that I don't have any friends within friends section" do
      visit dashboard_path

      within('.friends') do
        expect(page).to have_content("You don't have any friends... yet!")
      end
    end

    it "If I have friends, I see them within friends section" do
      @user1.friends << @user2
      @user1.friends << @user3

      visit dashboard_path

      within('.friends') do
        expect(page).to have_content(@user2.email)
        expect(page).to have_content(@user3.email)
      end
    end

    it 'I am able to add a friend that has an existing account' do 
      visit dashboard_path

      within('.friends') do
        fill_in :friend_email, with: "#{@user2.email}"
        click_button('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)

      within('.friends') do
        expect(page).to have_content(@user2.email)
      end

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

      visit dashboard_path

      within('.friends') do
        expect(page).to have_content(@user1.email)
      end
    end

    it 'I am unable to add a friend that does not have an account' do 
      visit dashboard_path

      within('.friends') do
        fill_in :friend_email, with: "elmer@barkmail.com"
        click_button('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("I'm sorry, your friend cannot be found.")

      within('.friends') do
        expect(page).to_not have_content("elmer@barkmail.com")
      end
    end

    it 'I am unable to add a friend that is already my friend' do 
      visit dashboard_path

      within('.friends') do
        fill_in :friend_email, with: "#{@user2.email}"
        click_button('Add Friend')
      end

      within('.friends') do
        fill_in :friend_email, with: "#{@user2.email}"
        click_button('Add Friend')
      end
      
      expect(page).to have_content("This person is already your friend :)")

      within('.friends') do
        expect(page).to have_content("#{@user2.email}", count: 1)
      end
    end

    it 'I am unable to add myself as a friend' do 
      visit dashboard_path

      within('.friends') do
        fill_in :friend_email, with: "#{@user1.email}"
        click_button('Add Friend')
      end

      expect(page).to have_content("Sorry, but you can't add yourself as friend, silly!")

      within('.friends') do
        expect(page).to_not have_content("#{@user1.email}")
      end
    end

    it "I am able to see any parties that I've been invited to" do
      PartyUser.create!(party_id: @party.id, user_id: @user1.id)

      visit dashboard_path
      within(first(".party")) do
        expect(page).to have_content('Casino')
        expect(page).to have_content('guest')
      end
    end

    it "I am able to see any parties that I am hosting" do
      PartyUser.create!(party_id: @party.id, user_id: @user1.id, attendee_type: 0)

      visit dashboard_path
      within(first(".party")) do
        expect(page).to have_content('Casino')
        expect(page).to have_content('host')
      end
    end

    describe 'That has not been invited to any parties' do
      it 'Do not see any parties on my dashboard' do
        visit dashboard_path

        expect(page).to_not have_css('.viewing-parties')
      end
    end
  end

  describe 'As an unauthenticated user' do
    it 'When manually type in /dashboard, I see an error or warning' do
      visit dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end