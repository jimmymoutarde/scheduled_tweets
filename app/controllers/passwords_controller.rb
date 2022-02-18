class PasswordsController < ApplicationController
	before_action :require_user_logged_in!

	def edit
	end

	def update
		respond_to do |format|
			if Current.user.update(password_params)
				format.html {redirect_to root_path, notice: "Password updated"}
			else
				format.html {render :edit, status: :unprocessable_entity}
			end
		end
	end

	private

	def password_params
		params.require(:user).permit(:password, :password_confirmation)
	end
end