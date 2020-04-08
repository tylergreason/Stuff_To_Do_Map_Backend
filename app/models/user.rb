class User < ApplicationRecord
    has_secure_password
    validates :email, :username, presence: true 
    validates :email, uniqueness: true 

    has_many :attractions, dependent: :destroy

    def change_password(current_password,new_password,new_password_confirmation) 
        if new_password == new_password_confirmation
            if self.authenticate(current_password)
                self.update(password:new_password)
                self.save
                # return self    
                return {:success => "Password changed"}
            else
                return {:error => "Incorrect password"}
            end
        else
                return {:error => "Passwords don't match"}
        end
    end

    def change_email(new_email, email_confirmation, current_password)
        if new_email == email_confirmation
            if self.authenticate(current_password)
                self.email = new_email 
                self.save 
                return {:success => "Email updated", :email => new_email}
            else 
                return {:error => "Incorrect password"}
            end
        else
            return {:error => "Emails don't match"}

        end
    end


end
