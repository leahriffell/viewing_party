# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PartyUser.destroy_all
Movie.destroy_all
Party.destroy_all
User.destroy_all

#users
user1 = User.create(email: 'user@user.com', password: 'password')
user2 = User.create(email: 'person@person.com', password: 'password')

#movies 
movie1 = Movie.create(id: 89, title: 'Indiana Jones and the Last Crusade')
movie2 = Movie.create(id: 123, title: 'The Lord of the Rings')

#parties
party1 = Party.create(movie_id: movie1.id, party_date: '12/1/2021', start_time: '7:00 pm', duration: 310)
party2 = Party.create(movie_id: movie2.id, party_date: '1/1/2021', start_time: '12:01 am', duration: 400)

#party users
PartyUser.create(party_id: party1.id, user_id: user1.id, attendee_type: 0)
PartyUser.create(party_id: party1.id, user_id: user2.id, attendee_type: 1)
PartyUser.create(party_id: party2.id, user_id: user2.id, attendee_type: 0)




