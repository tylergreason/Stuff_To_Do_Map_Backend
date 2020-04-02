require 'faker' 

# delete old data 
User.delete_all 
Attraction.delete_all 

# setup lat/lng generation based on Atlanta's coordinates 
southwestCoordinates = [33.696381, -84.434907]
northeastCoordinates = [33.783714, -84.340275]

# generate users 
3.times do 
    User.create( 
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name,
        username: Faker::Internet.username,
        email: Faker::Internet.email,
        password_digest: 'a',
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
        password_digest: 'a',
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country 
    )


# generate attractions 
10.times do 
Attraction.create(
                name: Faker::TvShows::TheExpanse.location,
                user_id:User.all.sample.id, 
                description: Faker::TvShows::HowIMetYourMother.quote,
                lng: rand(southwestCoordinates[1]..northeastCoordinates[1]) , 
                lat: rand(southwestCoordinates[0]..northeastCoordinates[0]),
                house_number:Faker::Address.building_number,
                road: Faker::Address.street_name, 
                city: Faker::Address.city, 
                state:Faker::Address.state, 
                country:Faker::Address.country
                )
end
