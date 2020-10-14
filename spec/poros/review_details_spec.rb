require 'rails_helper'

RSpec.describe 'ReviewDetails' do
  it 'exists' do
    attr = {
      author: 'Kris_12',
      url: 'https://www.google.com',
      content: 'Sharon Stone and Robert De Niro were amazing!'
    }
    review1 = ReviewDetails.new(attr)

    expect(review1).to be_a(ReviewDetails)
    expect(review1.author).to eq('Kris_12')
    expect(review1.url).to eq('https://www.google.com')
    expect(review1.content).to eq('Sharon Stone and Robert De Niro were amazing!')
  end
end