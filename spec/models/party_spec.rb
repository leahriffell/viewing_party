require 'rails_helper'

describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to :movie }
  end

  describe 'validations' do
    it { should validate_presence_of :party_date }
    it { should validate_presence_of :start_time }
  end
end
