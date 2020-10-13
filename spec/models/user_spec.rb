require 'rails_helper'

describe User, type: :model do
  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'instance methods' do
    before :each do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)

      @movie = Movie.create!(id: 524)
      @party1 = FactoryBot.create(:party)
      @party2 = FactoryBot.create(:party)

      PartyUser.create!(party_id: @party1.id, user_id: @user2.id)
      PartyUser.create!(party_id: @party2.id, user_id: @user2.id, attendee_type: 0)
    end

    describe 'any_parties?' do
      it 'determines if user is hosting or has been invited to any parties' do
        expect(@user1.any_parties?).to eq(false)
        expect(@user2.any_parties?).to eq(true)
      end
    end

    describe 'party_status' do
      it 'can return status for specific party based on party id' do
        expect(@user2.party_status(@party1.id)).to eq('guest')
        expect(@user2.party_status(@party2.id)).to eq('host')
      end
    end

    describe 'has_friends?' do
      it 'can determine if user has any friends or not' do
      expect(@user1.has_friends?).to eq(false)

      @user1.friends << @user2

      expect(@user1.has_friends?).to eq(true)
      end
    end
  end
end
