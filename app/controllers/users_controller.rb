class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update]
	before_filter :correct_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end
	
	def update
	  @user = User.find(params[:id])
	  if params[:user][:password].blank?
	    params[:user].delete(:password)
	    params[:user].delete(:password_confirmation)
	  end
	  if @user.update_attributes(params[:user])
	    flash[:success] = "Profile Updated"
	    sign_in @user
	    redirect_to @user
	  else
	    render 'edit'
	  end
	end

	private

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user==@user
	end

	def signed_in_user
		user_signed_in?
	end
end
