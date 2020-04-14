class UsersController < ApplicationController
    @@render_exclude_options = [:created_at, :updated_at, :password_digest]
    def create 
        @user = User.create(user_params)
        if @user.valid? 
            token = JWT.encode({user_id: @user.id}, ENV['SECRET'])
            render :json => { :token => token, :user => @user.user_info, :success => 'User created' }, :status => :ok 
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
        user = User.find(user_params[:id])
        render json: user.delete_user(user_params)
    end

    def update
        user_to_update = User.find(user_params[:id])
        if user_to_update.valid? 
            user_to_update.save 
            render json: user_to_update.update_info(user_params)
        else
            render :json => {:error => user_to_update.errors.full_messages}
        end
    end

    def update_password 
        user_to_update = User.find(user_params[:id])
        # byebug
        render json: user_to_update.change_password(user_params[:current_password],user_params[:password],user_params[:password_confirmation])
    end

    def update_email 
        user_to_update = User.find(user_params[:id])
        render json: user_to_update.change_email(user_params[:new_email], user_params[:email_confirmation], user_params[:current_password])
    end

    private 
    def user_params 
        params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :current_password, :password, :password_confirmation, :city, :state, :country,:new_email, :email_confirmation, :save_attractions,)
    end
end
