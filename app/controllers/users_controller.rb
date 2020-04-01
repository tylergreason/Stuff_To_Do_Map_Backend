class UsersController < ApplicationController
    def create 
        @user = User.create(user_params)
        token = JWT.encode({user_id: @user.id}, ENV['SECRET'])
        render json{token: token}, :status => :ok 
    end

    private 
    def user_params 
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :city, :state, :country)
    end
end
