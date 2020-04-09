class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: session_params[:email])
    
    if @user && @user.authenticate(session_params[:password])
        token = JWT.encode({user_id: @user.id}, ENV['SECRET'])
        render :json => { :token => token, :user => @user.user_info} , :status => :ok
    else
        render :json => {:error => "login failed!!"}
    end
  end

  private 
  def session_params 
    params.require(:user).permit(:email, :password)
  end
end
