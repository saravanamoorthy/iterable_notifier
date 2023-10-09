class ApplicationController < ActionController::Base
    
    def current_user
        @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
    end
    helper_method :current_user

    def authendicate_user!
        redirect_to new_session_path, alert: "You must login to access!" unless current_user
    end
end
