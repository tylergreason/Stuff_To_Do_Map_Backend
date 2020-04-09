class Attraction < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy

    validates :name, :description, :lat, :lng, presence: true
    validates :description, length: {in: 10..250}
    validates :name, length: {in: 5..25}
    validates :lat, :lng, numericality: true 
    
    def self.attractions_in_bounds(north, east, south, west)
        Attraction.select {|attraction|
            attraction.lat.between?(south,north) and attraction.lng.between?(west,east)
        }
    end

    def self.attractions_by_user(id) 
        Attraction.where(user_id: id) 
    end

    def average_rating
        ratings = self.reviews.map{|review| review.rating }
        ratings.sum/ratings.length 
    end
end
