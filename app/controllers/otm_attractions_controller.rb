class OtmAttractionsController < ApplicationController
    def index 
        north = request.headers['north'].to_f
        east = request.headers['east'].to_f
        south = request.headers['south'].to_f
        west = request.headers['west'].to_f
        
        otm_attractions = OtmAttraction.otm_attractions_in_bounds(north,east,south,west) 
        render :json => otm_attractions
        # attractions = Attraction.attractions_in_bounds(north,east,south,west)
        # render :json => attractions
    end
end
