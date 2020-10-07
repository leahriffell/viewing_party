require 'rails_helper'

RSpec.describe 'When a user visits the registration path' do
  before(:each) do
    @user1 = FactoryBot.create(:user)
  end

  it 'I see a form to register including email, password, password confirmation, and a button to submit' do
    visit(registration_path)

    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[password]')
    expect(page).to have_field('user[password_confirmation]')

    expect(page).to have_button('Create User')
  end

  it 'I see an error message and remain on the same page if I dont fill out all required fields' do
    visit(registration_path)

    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: "#{@user1.password}"
    fill_in 'user[password_confirmation]', with: "#{@user1.password}"

    click_button('Create User')
    expect(page).to have_content("Email can't be blank")
  end

  it 'I see an error message and remain on the same page if my email is not unique' do
    visit(registration_path)
    fill_in 'user[email]', with: "#{@user1.email}"
    fill_in 'user[password]', with: "#{@user1.password}"
    fill_in 'user[password_confirmation]', with: "#{@user1.password}"
    click_button('Create User')

    visit(registration_path)
    fill_in 'user[email]', with: "#{@user1.email}"
    fill_in 'user[password]', with: "#{@user1.password}"
    fill_in 'user[password_confirmation]', with: "#{@user1.password}"
    click_button('Create User')
    expect(page).to have_content('Email has already been taken')
  end

  it 'I fill out all fields, and use an unique email, click create user, I am logged in and returned to the dashboard page' do

    visit(registration_path)
    fill_in 'user[email]', with: 'elmer@barkmail.com'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with:'1234'
    click_button('Create User')

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Welcome elmer@barkmail.com!')
  end
end
