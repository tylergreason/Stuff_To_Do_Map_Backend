class Attraction < ApplicationRecord
    belongs_to :user

    def self.attractions_in_bounds(north, east, south, west)
        Attraction.select {|attraction|
            attraction.lat.between?(south,north) and attraction.lng.between?(west,east)
        }
    end

    def self.attractions_by_user(id) 
        Attraction.where(user_id: id) 
    end
end
