# == Schema Information
#
# Table name: spaces
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  name           :string(255)
#  description    :text
#  rules          :text
#  street_address :string(255)
#  locality       :string(255)
#  city           :string(255)
#  country        :string(255)
#  pincode        :integer
#  capacity       :integer
#  bedrooms       :integer
#  bathrooms      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  price          :float
#  room_type      :string(255)
#  amenities      :string(255)
#  size           :float
#  directions     :text
#

class Space < ActiveRecord::Base
	belongs_to :user
	has_many :photos, dependent: :destroy
	accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |pic| pic[picture].nil? }
	serialize :amenities
	attr_accessible :name,:description,:rules,:street_address,:locality,:city,:country,:pincode,
					:capacity,:bedrooms,:bathrooms,:room_type,:price,:amenities,:size,:directions

	validates :name, presence: true, length: { maximum: 50 }
	validates :locality, presence: true, length: { maximum: 50 }
	validates :city, presence: true, length: { maximum: 50 }
	validates :pincode, presence: true
	validates :bedrooms, presence: true
	validates :bathrooms, presence: true
	validates :street_address, presence: true, length: { maximum: 50 }
	validates :user_id, presence: true
	validates :price, presence:true
	validates :room_type, presence: true
	validates :description, length: { maximum: 1250 }
	validates :directions, length: { maximum: 1250 }

	def location
		locality + ", " + city + ", " + country
	end
end
