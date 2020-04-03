class AttractionsController < ApplicationController
    def index 
        # byebug
        # bounds = request.headers['bounds']
        north = request.headers['north']
        south = request.headers['south']
        east = request.headers['east']
        west = request.headers['east']

        attractions = Attraction.all 
        render :json => attractions
    end

    def getAttractionsByBounds 
        byebug
        attractions = Attraction.all 
        render :json => attractions
    end

end
