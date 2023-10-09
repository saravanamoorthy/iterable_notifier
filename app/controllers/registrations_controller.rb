class RegistrationsController < ApplicationController
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(user_params)
			if @user.save
				session[:user_id] = @user.id
				redirect_to events_path, notice: "Registered successfully!"
			else
				puts @user.errors.any?
        flash.now[:error] = "Unable to register!"
        render :new
      end
    end
    
    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
        end
  end