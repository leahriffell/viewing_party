require 'rails_helper'

RSpec.describe 'Movie' do
    it 'exists' do
        attr = {
            title: 'Nic Eats a Hamburger',
            vote_average: 10
        }
        movie1 = MovieCreator.new(attr)

        expect(movie1).to be_a(MovieCreator)
        expect(movie1.title).to eq('Nic Eats a Hamburger')
        expect(movie1.vote_average).to eq(10)
    end
end