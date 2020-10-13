require 'rails_helper'

RSpec.describe 'Movie' do
    it 'exists' do
        attr = {
            title: 'Nic Eats a Hamburger',
            vote_average: 10,
            release_date: '2020-10-01',
            genres: [{id: 80, name: 'Crime'}, {id: 99, name: 'Drama'}],
            runtime: 179,
            overview: 'Award winning movie about a guy eating a hamburger'
        }
        movie1 = MovieCreator.new(attr)

        expect(movie1).to be_a(MovieCreator)
        expect(movie1.title).to eq('Nic Eats a Hamburger')
        expect(movie1.vote_average).to eq(10)
        expect(movie1.release_date).to eq('2020-10-01')
        expect(movie1.genres).to eq([{id: 80, name: 'Crime'}, {id: 99, name: 'Drama'}])
        expect(movie1.runtime).to eq(179)
        expect(movie1.overview).to eq('Award winning movie about a guy eating a hamburger')
    end
end