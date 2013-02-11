# == Schema Information
#
# Table name: booking_requests
#
#  id          :integer          not null, primary key
#  space_id    :integer
#  guest_id    :integer
#  host_id     :integer
#  start_date  :date
#  end_date    :date
#  amount      :float
#  fees        :float
#  rent        :float
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  guests      :integer          default(1)
#

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
