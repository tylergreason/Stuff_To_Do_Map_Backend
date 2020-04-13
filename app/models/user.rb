class User < ApplicationRecord
    has_secure_password
    validates :email, :username, presence: true 
    validates :email, uniqueness: true 

    has_many :attractions, dependent: :destroy
    has_many :reviews, dependent: :destroy

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

    def update_info(info)
        if self.authenticate(info[:password])
            # get the user_params hash without the password 
            # we do NOT want to update the user's password here 
            info_without_password = info.select{|k| k != "password"}
            self.update(info_without_password) 
            self.save 
            self_to_return = self.attributes.select{|k| k!= "password_digest" && k!= 'created_at' && k != 'updated_at'}
            return {:success => "Information updated", :user => self_to_return}
            # , :except => [:created_at, :updated_at, :password_digest]
            # return :success => "Infomation updated", :user => self
            # , :except => [:created_at, :updated_at, :password_digest]
        else
            return {:error => "Incorrect password"}
        end
    end

    # method to reassign attractions and reviews that are going to be deleted to user 1
    def reasign_list_to_1(list)
        user_1 = User.find(1)
        list.each {|item|
            item.user = user_1
            item.save 
        }
    end

    def delete_user(info)
        if self.authenticate(info[:password])
            if info[:save_attractions] == false 
                self.destroy
                return {:success => "User deleted"}
            else 
                # find some user to give ownership of this user's attractions to another user
                #  using delete because it does not delete this user's attractions 
                reasign_list_to_1(self.reviews) 
                reasign_list_to_1(self.attractions)
                self.delete 
                return {:success => "User deleted"}
            end
        else
            return {:error => "Incorrect password"} 
        end
    end

    def user_info 
        {
            id:self.id, 
            first_name:self.first_name,
            last_name:self.last_name, 
            username:self.username,
            email:self.email,
            city:self.city,
            state:self.state,
            country:self.country
        }
    end


end
