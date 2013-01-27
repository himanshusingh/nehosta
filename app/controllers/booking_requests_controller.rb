class BookingRequestsController < ApplicationController
	before_filter :signed_in_user
	before_filter :validate_dates, only: [:create]
	before_filter :admin_user, only: [:index]

	def index
		@requests = BookingRequest.all
	end

	def create
		@space = Space.find(params[:booking_request][:space_id])
		start_date = Date.parse(params[:booking_request][:start_date])
		end_date = Date.parse(params[:booking_request][:end_date])
		rent = ((end_date-start_date).to_i)*(@space.price)
		fees = (rent*0.0967).floor + 100
		amount = rent + fees
		params[:booking_request][:rent] = rent
		params[:booking_request][:fees] = fees
		params[:booking_request][:amount] = amount
		@request = current_user.issued_requests.new(params[:booking_request])
		if @request.save
			respond_to do |format|
			  format.html { redirect_to @space }
			  format.js
			end
		else
			respond_to do |format|
			  format.html { redirect_to @space }
			  format.js
			end
		end
	end

	def destroy
		@request = current_user.issued_requests.find_by_id(params[:id])
		@space = Space.find(@request.space_id)
		@request.destroy
		respond_to do |format|
		  format.html { redirect_to @space }
		  format.js
		end
	end

	private

	def validate_dates
		@space = Space.find(params[:booking_request][:space_id])
		if (((start_date = Date.parse(params[:booking_request][:start_date]) rescue ArgumentError) == ArgumentError) ||
			((end_date = Date.parse(params[:booking_request][:end_date]) rescue ArgumentError) == ArgumentError) || (start_date > end_date))
			redirect_to @space
		end
	end
end