class Attraction < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy

    validates :name, :description, :lat, :lng, presence: true
    validates :description, length: {in: 10..250}
    validates :name, length: {in: 5..25}
    validates :lat, :lng, numericality: true 
    
    def self.attractions_in_bounds(north, east, south, west)
        attractions = Attraction.select {|attraction|
            attraction.lat.between?(south,north) and attraction.lng.between?(west,east)
        }
        # return_attractions = attractions.map{|a| a.to_json(except: [:created_at, :updated_at], methods: :average_rating)}
        new_attractions = attractions.map {|a| {
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
