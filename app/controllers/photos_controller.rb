class PhotosController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy, :update, :edit]
	before_filter :correct_user, only: [:create, :destroy, :update, :edit]
	def create
		@space = Space.find_by_id(params[:space_id])
		@photo = @space.photos.build(params[:photo])
		if @photo.save
			respond_to do |format|
				format.js
				format.html { redirect_to edit_space_path(@space) }
			end
		else
			respond_to do |format|
				format.js
				format.html { redirect_to edit_space_path(@space) }
			end
		end
	end

	def destroy
		@space = Space.find_by_id(params[:space_id])
		@photo = @space.photos.find(params[:id])
		@photo.destroy
		respond_to do |format|
			format.js
			format.html { redirect_to @space }
		end
	end

	def edit
		@space = Space.find_by_id(params[:space_id])
		@photo = @space.photos.find(params[:id])
	end

	def update
		@space = Space.find_by_id(params[:space_id])
		@photo = @space.photos.find(params[:id])
		if @photo.update_attributes(params[:photo])
			respond_to do |format|
				format.js
				format.html { redirect_to edit_space_path(@space) }
				format.json { respond_with_bip(@photo) }
			end
		else
			respond_to do |format|
				format.js
				format.html { redirect_to edit_space_path(@space) }
				format.json { respond_with_bip(@photo) }
			end
		end
	end

	private

	def correct_user
		@space = current_user.spaces.find_by_id(params[:space_id])
		redirect_to root_path unless @space || current_user.try(:admin?) 
	end
end