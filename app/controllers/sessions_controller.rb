class SessionsController < ApplicationController
    def new
      # Render the login form
      @user = User.new
    end
    
    def create
      # Find the user by email
      user = User.find_by(email: params[:email])
      
      # If the user exists and the password is correct
      if user && user.authenticate(params[:password])
        # Save the user's ID in the session and redirect to the events page
        session[:user_id] = user.id
        redirect_to events_path
      else
        # Show an error message and render the login form again
        flash.now[:error] = "Invalid email or password"
        render :new
      end
    end
    
    def destroy
      # Clear the session and redirect to the login page
      session[:user_id] = nil
      redirect_to login_path, notice: "Logout successfully!"
    end
  end