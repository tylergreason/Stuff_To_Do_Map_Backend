class UsersController < ApplicationController
    def create 
        @user = User.create(user_params)
        
        # byebug
        if @user.valid? 
            token = JWT.encode({user_id: @user.id}, ENV['SECRET'])
            render :json => { :token => token }, :status => :ok 
        else
            render :json => {:error => @user.errors.full_messages}
        end
    end

    # custom route for getting current user info without needing user ID on front end 
    def my_account 
        @user = current_user 
        render :json => @user 
    end

    def destroy 
        @user = User.find_by(email: user_params[:email])
        # make the user enter their password before deletion 
        if @user && @user.authenticate(user_params[:password])
            @user.delete
            render :json => {:msg => "user deleted"}
        else 
            render :json => {:error => @user.error.full_messages}
        end 
    end

    def update
        user_to_update = User.find(user_params[:id])
        user_to_update.update(user_params) 
        user_to_update.save 
        render :json => user_to_update
    end

    private 
    def user_params 
        params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :password, :city, :state, :country)
    end
end
