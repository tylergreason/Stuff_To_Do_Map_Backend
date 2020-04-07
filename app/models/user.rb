class User < ApplicationRecord
    has_secure_password
    validates :email, :username, :password, presence: true 
    validates :email, uniqueness: true 

    has_many :attractions, dependent: :destroy
end
