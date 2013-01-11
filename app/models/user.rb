# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  description            :text
#  location               :string(255)
#  birthday               :date
#  sex                    :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  fb_url                 :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :spaces, dependent: :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :birthday, :description, :fb_url, :first_name, :last_name, :location, :provider, :sex, :uid, :avatar

  # Validations
  validates_attachment_size :avatar, less_than: 5.megabytes
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png']
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :first_name, length: { maximum: 50 }
  validates :sex, presence: true
  validates :description, length: { maximum: 1250 }

  # Avatar
  has_attached_file :avatar, 
    url: "/:attachment/:id/:style/:basename.:extension",
    default_url: "/images/missing_:style.jpg",
    path: ":rails_root/public/:attachment/:id/:style/:basename.:extension",
    styles: { medium: "640x480>", thumb: "100x100>", small: "40x40>" }

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    	if signed_in_resource
    		signed_in_resource.provider = auth.provider
    		signed_in_resource.uid = auth.uid
    		signed_in_resource.fb_url = auth.extra.raw_info.link
    		signed_in_resource.sex = auth.extra.raw_info.gender if signed_in_resource.sex.nil?
    		signed_in_resource.first_name = auth.info.first_name if signed_in_resource.first_name.nil?
    		signed_in_resource.last_name = auth.info.last_name if signed_in_resource.last_name.nil?
    		signed_in_resource.location = auth.info.location if signed_in_resource.location.nil?
    		signed_in_resource.birthday = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y') if signed_in_resource.birthday.nil?
    		signed_in_resource.save!
    		return signed_in_resource
    	elsif User.find_by_email(auth.info.email)
        user = User.find_by_email(auth.info.email)
        return user if user.fb_url
        user.provider = auth.provider
        user.uid = auth.uid
        user.fb_url = auth.extra.raw_info.link
        user.sex = auth.extra.raw_info.gender if user.sex.nil?
        user.first_name = auth.info.first_name if user.first_name.nil?
        user.last_name = auth.info.last_name if user.last_name.nil?
        user.location = auth.info.location if user.location.nil?
        user.birthday = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y') if user.birthday.nil?
        user.save!
        return user
      else
    		user = User.create(provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           birthday:Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y'),
                           sex: auth.extra.raw_info.gender,
                           first_name: auth.info.first_name,
                           last_name: auth.info.last_name,
                           location: auth.info.location,
                           fb_url: auth.extra.raw_info.link
                           )
    	end
    end
    user
  end
end
