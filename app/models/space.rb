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
#

class Space < ActiveRecord::Base
	belongs_to :user
	has_many :photos, dependent: :destroy
	accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |pic| pic[picture].nil? }
	attr_accessible :name,:description,:rules,:street_address,:locality,:city,:country,:pincode,:capacity,:bedrooms,:bathrooms

	validates :name, presence: true
	validates :locality, presence: true
	validates :city, presence: true
	validates :pincode, presence: true
	validates :bedrooms, presence: true
	validates :bathrooms, presence: true
	validates :street_address, presence: true
	validates :user_id, presence: true
	validates :price, presence:true
	validates :room_type, presence: true
end
