require 'rails_helper'

describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to :movie }
  end

  describe 'validations' do
    it { should validate_presence_of :party_date }
    it { should validate_presence_of :start_time }
  end

  describe 'instance methods' do
    before :each do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @user3 = FactoryBot.create(:user)

      @movie = Movie.create!(id: 524)
      @party1 = FactoryBot.create(:party)
      @party2 = FactoryBot.create(:party)
    end

    describe 'invite' do
      it 'invites an array of users' do
        expect(@party1.users).to eq([])

        @party1.invite(["", @user2.id.to_s, @user3.id.to_s])

        expect(@party1.users).to eq([@user2, @user3])
      end
    end

    describe 'invitees' do
      it 'can get all invited guests (not host) for a party' do
        PartyUser.create(party_id: @party1.id, user_id: @user1.id, attendee_type: 0)
        PartyUser.create(party_id: @party1.id, user_id: @user2.id)
        PartyUser.create(party_id: @party1.id, user_id: @user3.id)

        PartyUser.create(party_id: @party2.id, user_id: @user3.id)

        expect(@party1.invitees).to eq([@user2, @user3])
      end
    end
  end
end
