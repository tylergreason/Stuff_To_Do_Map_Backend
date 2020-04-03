class AttractionsController < ApplicationController
    def index 
        # byebug
        # bounds = request.headers['bounds']
        north = request.headers['north'].to_f
        east = request.headers['east'].to_f
        south = request.headers['south'].to_f
        west = request.headers['west'].to_f
        
        attractions = Attraction.attractions_in_bounds(north,east,south,west)
        render :json => attractions
    end

    def my_attractions
        # byebug
        p 'this is my_attractions'
        my_attractions = Attraction.where(user_id: current_user.id)
        p my_attractions
        render :json => my_attractions
    end

end
