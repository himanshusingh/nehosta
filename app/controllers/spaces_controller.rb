class SpacesController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :create, :destroy, :new, :update]
	before_filter :correct_user, only: [:edit, :destroy, :update]

	def new
		@space = current_user.spaces.build
	end

	def index
		@spaces = Space.paginate(page: params[:page])
	end

	def show
		@space = Space.find(params[:id])
		@host = @space.user if @space
	end

	def edit
		@space = Space.find(params[:id])
	end

	def create
		@space = current_user.spaces.build(params[:space])
		if @space.save
			flash[:success] = "Successfuly added. Now add description and photos to your space to make it visible!"
			redirect_to edit_space_path(@space)
		else
			render 'new'
		end
	end

	def update
		@space = Space.find(params[:id])
		respond_to do |format|
			if @space.update_attributes(params[:space])
				format.html { redirect_to(edit_space_path(@space), notice: 'Info Updated') }
				format.json { respond_with_bip(@space) }
			else
				format.html { render 'edit' }
				format.json { respond_with_bip(@space) }
			end
		end
	end

	def destroy
		@space = Space.find(params[:id])
		@user = @space.user
		@space.destroy
		redirect_to @user
	end

	private

	def correct_user
		@space = Space.find(params[:id])
		@user = @space.user
		redirect_to root_path unless current_user==@user || is_admin?
	end

end
