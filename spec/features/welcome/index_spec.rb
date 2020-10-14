require 'rails_helper'

RSpec.describe 'Welcome page' do
  describe 'As a registered user' do
    before :each do 
      @user = FactoryBot.create(:user)
    end

    describe 'I cannot log in with incorrect credentials' do
      it 'enters email not in system' do 
        visit root_path
      
        fill_in 'Email', with: 'wrongemail@email.com'
        fill_in 'Password', with: @user.password
        click_button 'Log In'
        
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Incorrect email or password.')
      end
      
      it 'enters incorrect password' do 
        visit root_path
      
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'wrongpassword'
        click_button 'Log In'
        
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Incorrect email or password.')
      end
    end

    it 'I can log in with correct credentials' do 
      visit root_path
      
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.email}!")
    end
  end

  describe 'As a logged in user' do
    before :each do 
      @user = FactoryBot.create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I do not see log in form' do
      visit root_path

      expect(page).to_not have_content('Log in:')
      expect(page).to_not have_field('Email')
      expect(page).to_not have_field('Password')
      expect(page).to_not have_button ('Log in')
      expect(page).to_not have_link ('New to Viewing Party? Register Here')
    end

    it 'I can link to my dashboard' do      
      visit root_path
      
      click_link('Go to dashboard')
      expect(current_path).to eq(dashboard_path)
    end
  end

  describe 'As a visitor' do 
    it 'can access the registration form' do 
      visit root_path

      click_link 'New to Viewing Party? Register Here'
      expect(current_path).to eq(registration_path)
    end
  end
end