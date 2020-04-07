class Attraction < ApplicationRecord
    belongs_to :user
    validates :name, :description, :lat, :lng, presence: true

    def self.attractions_in_bounds(north, east, south, west)
        Attraction.select {|attraction|
            attraction.lat.between?(south,north) and attraction.lng.between?(west,east)
        }
    end

    def self.attractions_by_user(id) 
        Attraction.where(user_id: id) 
    end
end
