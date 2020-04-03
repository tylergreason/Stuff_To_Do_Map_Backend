class AttractionsController < ApplicationController
    def index 
        # byebug
        # bounds = request.headers['bounds']
        north = request.headers['north'].to_f
        east = request.headers['east'].to_f
        south = request.headers['south'].to_f
        west = request.headers['west'].to_f

        attractions = Attraction.attractions_in_bounds(north,east,south,west)
        p north 
        p south
        p west 
        p east
        p attractions
        render :json => attractions
    end

    def getAttractionsByBounds 
        byebug
        attractions = Attraction.all 
        render :json => attractions
    end

end
