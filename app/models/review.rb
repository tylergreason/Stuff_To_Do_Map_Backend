class Review < ApplicationRecord
    belongs_to :user 
    belongs_to :attraction

    def self.review_with_user(reviews) 
        return reviews.map{|r| {
            id:r.id, 
            rating:r.rating, 
            text:r.text, 
            user_first_name:r.user.first_name, 
            user_last_name:r.user.last_name, 
            created_at: r.created_at
        }}
    end
end
