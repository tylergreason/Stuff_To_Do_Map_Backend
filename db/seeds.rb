require 'faker' 

# delete old data 
User.delete_all 
Attraction.delete_all 

# setup lat/lng generation based on Atlanta's coordinates 
atlantaSouthwestCoordinates = [33.696381, -84.434907]
atlantaNortheastCoordinates = [33.783714, -84.340275]
midwestSouthwestCoordinates = [29.592565403314087, -98.45659819956116]
midwestNortheastCoordinates = [43.628123412124616, -83.07573882456116]


# south: 29.592565403314087
# north: 43.628123412124616
# east: -83.07573882456116
# west: -98.45659819956116

# generate users 
3.times do |time|
    User.create( 
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name,
        username: Faker::Internet.username,
        email: time,
        password: 'a',
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country 
    )
end
# generate one more user with known email for easy testing 
User.create( 
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name,
        username: Faker::Internet.username,
        email: 'test@mail.com',
        password: 'a',
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country 
    )


# generate attractions in Atlanta 
10.times do 
    Attraction.create(
        name: Faker::Games::Fallout.location,
        user_id:User.all.sample.id, 
        description: Faker::Lorem.paragraph,
        lng: rand(atlantaSouthwestCoordinates[1]..atlantaNortheastCoordinates[1]) , 
        lat: rand(atlantaSouthwestCoordinates[0]..atlantaNortheastCoordinates[0]),
        house_number:Faker::Address.building_number,
        road: Faker::Address.street_name, 
        city: "Atlanta", 
        state:Faker::Address.state, 
        country:Faker::Address.country
        )
end

50.times do 
    Attraction.create(
        name:Faker::Games::Zelda.location,
        user_id:User.all.sample.id, 
        description: Faker::Quote.matz,
        lng: rand(midwestSouthwestCoordinates[1]..midwestNortheastCoordinates[1]) , 
        lat: rand(midwestSouthwestCoordinates[0]..midwestNortheastCoordinates[0]),
        house_number:Faker::Address.building_number,
        road: Faker::Address.street_name, 
        city: Faker::Address.city, 
        state:Faker::Address.state, 
        country:Faker::Address.country
    )
end




