class AttractionsController < ApplicationController
    # define arrays for what to include or exclude when rendering 
    @@render_exclude_options = [:created_at, :updated_at]
    @@render_review_include_options = [:text, :rating]

    def index 
        north = request.headers['north'].to_f
        east = request.headers['east'].to_f
        south = request.headers['south'].to_f
        west = request.headers['west'].to_f
        
        attractions = Attraction.attractions_in_bounds(north,east,south,west)
        render :json => attractions
    end

    # custom route for current user's attractions 
    def my_attractions
        my_attractions = Attraction.attractions_by_user(current_user.id)
        render :json => Attraction.just_attraction_data(my_attractions), :except => @@render_exclude_options
    end

    def destroy 
        attraction_to_delete = Attraction.find(params[:id])
        attraction_to_delete.delete 
        my_attractions = Attraction.attractions_by_user(current_user.id)
        render :json => my_attractions, :except => @@render_exclude_options
    end

    def update 
        attraction_to_update = Attraction.find(attraction_params[:id])
        attraction_to_update.update(attraction_params)
        attraction_to_update.save
        my_attractions = Attraction.attractions_by_user(current_user.id)
        render :json => my_attractions, :exclude => @@render_exclude_options
    end

    def create 
        new_attraction = Attraction.create(attraction_params) 
        new_attraction.user_id = current_user.id 
        if new_attraction.valid? 
            new_attraction.save
            my_attractions = Attraction.attractions_by_user(current_user.id)
            render :json => my_attractions, :exclude => @@render_exclude_options
        else
            render :json => {:error => new_attraction.errors.full_messages}
        end 
    end

    def show 
        attraction = Attraction.find(params[:id])
        # byebug
        render :json => attraction.attraction_with_reviews
    end

    private 
    def attraction_params 
        params.require(:attraction).permit(:id,:name,:description,:user_id,:lng,:lat,:house_number,:road,:city,:state,:country)
    end



end
