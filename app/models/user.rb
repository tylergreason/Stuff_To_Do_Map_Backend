class User < ApplicationRecord
    has_secure_password
    validates :email, :username, presence: true 
    validates :email, uniqueness: true 

    has_many :attractions, dependent: :destroy

    def change_password(current_password,password,password_confirmation) 
        if password == password_confirmation
            if self.authenticate(current_password)
                self.update(password:password)
                self.save
                return self    
            else
                render :json => {:error => "Incorrect password"}
            end
        else
            render :json => {:error => "Passwords don't match"}
        end
    end
end
