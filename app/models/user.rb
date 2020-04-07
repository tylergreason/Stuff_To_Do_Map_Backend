class User < ApplicationRecord
    has_secure_password
    validates :email, :username, presence: true 
    validates :email, uniqueness: true 

    has_many :attractions, dependent: :destroy
end
