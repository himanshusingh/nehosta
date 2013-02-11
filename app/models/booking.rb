# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  space_id   :integer
#  guest_id   :integer
#  host_id    :integer
#  start_date :date
#  end_date   :date
#  amount     :float
#  fees       :float
#  rent       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Booking < ActiveRecord::Base
  	belongs_to :guest, class_name: 'User'
  	belongs_to :host, class_name: 'User'
  	belongs_to :space

  	belongs_to :guest, class_name: 'User'
  	belongs_to :host, class_name: 'User'
  	belongs_to :space
  	validates :start_date, presence: true
  	validates :end_date, presence: true
  	validates :host_id, presence: true
  	validates :space_id, presence: true
  	validates :fees, presence: true
  	validates :rent, presence: true
  	validates :amount, presence: true
  	validates :guest_id, presence: true

    attr_accessible :space_id, :host_id, :start_date, :end_date, :amount, :fees, :rent
end
