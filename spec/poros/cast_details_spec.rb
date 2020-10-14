require 'rails_helper'

RSpec.describe 'CastDetails' do
  it 'exists' do
    attr = {
      name: 'Robert De Niro',
      character: 'Sam \'Ace\' Rothstein'
    }
    cast1 = CastDetails.new(attr)

    expect(cast1).to be_a(CastDetails)
    expect(cast1.name).to eq('Robert De Niro')
    expect(cast1.character).to eq('Sam \'Ace\' Rothstein')
  end
end