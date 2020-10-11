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
      @party = FactoryBot.create(:party)
    end

    describe 'any_parties?' do
      it 'determines if user is hosting or has been invited to any parties' do
        PartyUser.create!(party_id: @party.id, user_id: @user2.id)

        expect(@user1.any_parties?).to eq(false)
        expect(@user2.any_parties?).to eq(true)
      end
    end
  end
end
