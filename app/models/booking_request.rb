class BookingRequest < ActiveRecord::Base
	belongs_to :guest, class_name: 'User'
	belongs_to :host, class_name: 'User'
	belongs_to :space
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :description, length: { maximum: 3000 }
	validates :host_id, presence: true
	validates :space_id, presence: true
	validates :fees, presence: true
	validates :rent, presence: true
	validates :amount, presence: true
	validates :guest_id, presence: true

  	attr_accessible :space_id, :host_id, :start_date, :end_date, :amount, :fees, :rent, :description, :guests
end
