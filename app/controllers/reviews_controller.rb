class ReviewsController < ApplicationController

    def create 
        new_review = Review.create(review_params) 
        new_review.user_id = current_user.id 
        new_review.save
        # byebug
        if new_review.valid? 
            render :json => {:attraction => new_review.attraction.attraction_with_reviews, :success => "Review added!"}
        else
            render :json => {:error => new_review.errors.full_messages}
        end
    end

    def destroy 
        review = Review.find(review_params[:id]) 
        # byebug
        attraction_to_return = review.attraction 
        review.destroy 
        render :json => {:attraction => attraction_to_return.attraction_with_reviews, :success => "Review deleted!"}
    end

    private
    def review_params 
        params.require(:review).permit(:id,:rating,:text,:user_id,:attraction_id)
    end
end
