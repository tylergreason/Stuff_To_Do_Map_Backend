class AttractionsController < ApplicationController
    def index 
        attractions = Attraction.all 
        render :json => attractions
    end
end
