class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :birthday, :description, :fb_url, :first_name, :last_name, :location, :provider, :sex, :uid, :avatar

  # Validations
  validates_attachment_size :avatar, less_than: 1.megabytes
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png']

  # Avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    	if signed_in_resource && (signed_in_resource.email == auth.info.email)
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
