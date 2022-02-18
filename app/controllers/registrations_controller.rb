class RegistrationsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

	    respond_to do |format|
	      if @user.save
	      	session[:user_id] = @user.id
	        format.html { redirect_to root_path, notice: "User was successfully created." }
	        format.json { render :show, status: :created, location: @user }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end