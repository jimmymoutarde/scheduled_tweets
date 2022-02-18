class PasswordResetsController < ApplicationController
	def new

	end

	def create
		@user = User.find_by(email: params[:email])

		respond_to do |format|
			if @user.present?
				#Send email
				PasswordMailer.with(user: @user).reset.deliver_now
			end

			format.html { redirect_to root_path, notice: "We sent a link to reset your password" }
		end
	end

	def edit
		@user = User.find_signed!(params[:token], purpose: "password_reset")
	rescue ActiveSupport::MessageVerifier::InvalidSignature
		redirect_to sign_in_path, alert:"Your link has expired. Please try again"
	end

	def update
		@user = User.find_signed!(params[:token], purpose: "password_reset")

		respond_to do |format|
			if @user.update(password_params)
				format.html {redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."}
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