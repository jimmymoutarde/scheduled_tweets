class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:email])

		respond_to do |format|
			if user.present? && user.authenticate(params[:password])
				session[:user_id] = user.id
				format.html {redirect_to root_path, notice: "Logged in successfully"}
			else
				flash[:alert] = "Invalid email or password"
				format.html {render :new, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "Logged Out"
	end
end