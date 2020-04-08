class UsersController < ApplicationController
    @@render_exclude_options = [:created_at, :updated_at, :password_digest]
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
        user = current_user 
        render :json => user, :except => @@render_exclude_options  
    end

    def destroy 
        @user = User.find_by(email: user_params[:email])
        # make the user enter their password before deletion 
        if @user && @user.authenticate(user_params[:current_password])
            @user.delete
            render :json => {:msg => "user deleted"}
        else 
            render :json => {:error => @user.error.full_messages}
        end 
    end

    def update
        user_to_update = User.find(user_params[:id])
        if user_to_update && user_to_update.authenticate(user_params[:password])

            user_to_update.update(user_params.except(:password)) 
            user_to_update.save 
            render :json => user_to_update, :except => @@render_exclude_options
        else 
            render :json => {:error => user_to_update.errors.full_messages}
        end
    end

    def update_password 
        user_to_update = User.find(user_params[:id])
        byebug
    end

    private 
    def user_params 
        params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :current_password, :password, :password_confirmation, :city, :state, :country)
    end
end
