require 'rails_helper'

describe PartyUser, type: :model do
  describe 'relationships' do
    it { should belong_to :party }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :attendee_type }
  end
end