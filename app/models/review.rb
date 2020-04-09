class Review < ApplicationRecord
    belongs_to :user 
    belongs_to :attraction

    validates :text, :rating, presence: true
    validates :text, length: {in: 5..250}
    validates :rating, numericality: {only_integer: true }

    def self.review_with_user(reviews) 
        return reviews.map{|r| {
            id:r.id, 
            rating:r.rating, 
            text:r.text, 
            user_id:r.user_id,
            user_first_name:r.user.first_name, 
            user_last_name:r.user.last_name, 
            created_at: r.created_at.to_date
        }}
    end

    def render_review
        {
            id:self.id, 
            text:self.text, 
            attraction_id:self.attraction_id, 
            user_id: self.user_id, 
            user_first_name:self.user.first_name, 
            user_last_name:self.user.last_name, 
            rating: self.rating,
            attraction_average_rating: self.attraction.average_rating,
            created_at: self.created_at.to_date
        }
    end
end
