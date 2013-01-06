# == Schema Information
#
# Table name: photos
#
#  id                   :integer          not null, primary key
#  caption              :string(255)      default("")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Photo < ActiveRecord::Base
	belongs_to :space
	validates :space_id, presence: true	
	validates_attachment_presence :picture
	validates_attachment_size :picture, less_than: 5.megabytes
	validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/png']
	attr_accessible :picture, :caption

	has_attached_file :picture, 
	  url: "/:attachment/:id/:style/:basename.:extension",
	  default_url: "/images/missing_:style.jpg",
	  path: ":rails_root/public/:attachment/:id/:style/:basename.:extension",
	  styles: { gallery: "686x482#", medium: "260x180#", thumb: "160x160#", small: "40x40#" }
end
