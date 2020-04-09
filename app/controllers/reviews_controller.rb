class ReviewsController < ApplicationController

    def create 
        new_review = Review.create(review_params) 
        new_review.user_id = current_user.id 
        new_review.save
        # byebug
        if new_review.valid? 
            render :json => {:review => new_review.render_review, :success => "Review added!"}
        else
            render :json => {:error => new_review.errors.full_messages}
        end
    end

    private
    def review_params 
        params.require(:review).permit(:id,:rating,:text,:user_id,:attraction_id)
    end
end
