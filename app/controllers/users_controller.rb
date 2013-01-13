class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :delete_photo]
	before_filter :correct_user, only: [:edit, :update, :delete_photo]
	before_filter :admin_user, only: [:index, :destroy]

	def index
	  @users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end
	
	def update
	  @user = User.find(params[:id])
	  if params.has_key?(:user)
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
	  else
	  	redirect_to @user
	  end
	end

	def delete_photo
		@user = User.find(params[:id])
		@user.avatar.destroy
		@user.save
		redirect_to @user
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to root_path
	end

	def spaces
		@spaces = Space.paginate(page: params[:page], conditions: ['user_id = ?', params[:id]])
	end

	private

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user==@user || current_user.try(:admin?)
	end
end
