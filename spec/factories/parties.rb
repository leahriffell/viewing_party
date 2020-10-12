FactoryBot.define do
  factory :party do
    movie_id { '524' }
    party_date { Faker::Date.forward }  
    start_time { "8:00 pm" }  
    duration { Faker::Number.between(from: 1, to: 500) }  
    # association :movie
  end
end
