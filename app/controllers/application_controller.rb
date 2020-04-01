class ApplicationController < ActionController::API
    def authorize!
        unless current_user 
            return nil 
        end
    end
    
    def current_user
        token = request.headers['Access-Token']
        user_id = JWT.decode(token,ENV['SECRET'])[0]["user_id"]
        current = User.find_by(:id => user_id)
    end
end
