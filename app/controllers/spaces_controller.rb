class SpacesController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :create, :destroy, :new]

	def new
		@space = current_user.spaces.build
	end

	def index
		@spaces = Space.all
	end

	def show
		@space = Space.find_by_id(params[:id])
	end

	def edit
	end

	def create
	end

	def destroy
	end

end
