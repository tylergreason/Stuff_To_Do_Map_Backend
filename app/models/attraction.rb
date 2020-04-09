class Attraction < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy

    validates :name, :description, :lat, :lng, presence: true
    validates :description, length: {in: 10..250}
    validates :name, length: {in: 5..25}
    validates :lat, :lng, numericality: true 
    
    # method to return just the data we need when returning attractions 
    def self.just_attraction_data(array) 
        return array.map {|a| {
            id:a.id, 
            name: a.name,
            user_id: a.user_id,
            description: a.description,
            lng: a.lng,
            lat: a.lat,
            house_number: a.house_number,
            road: a.road,
            city: a.city,
            state: a.state,
            country: a.country,
            average_rating: a.average_rating
        }}
    end

    def attraction_with_reviews 
        {
            id:self.id, 
            name: self.name,
            user_id: self.user_id,
            description: self.description,
            lng: self.lng,
            lat: self.lat,
            house_number: self.house_number,
            road: self.road,
            city: self.city,
            state: self.state,
            country: self.country,
            average_rating: self.average_rating,
            reviews:self.reviews
        }
    end
    def self.attractions_in_bounds(north, east, south, west)
        attractions = Attraction.select {|attraction|
            attraction.lat.between?(south,north) and attraction.lng.between?(west,east)
        }
        return just_attraction_data(attractions)
    end

    def self.attractions_by_user(id) 
        Attraction.where(user_id: id) 
    end

    def average_rating
        if self.reviews.length > 0 
            ratings = self.reviews.map{|review| review.rating }
            ratings.sum/ratings.length 
        else 
            nil
        end
    end

end
