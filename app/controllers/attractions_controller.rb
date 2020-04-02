class AttractionsController < ApplicationController
    def index 
        attractions = Attraction.all 
        return attractions
    end
end
