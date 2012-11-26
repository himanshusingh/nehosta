class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :birthday, :description, :fb_url, :first_name, :last_name, :location, :provider, :sex, :uid

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    	if signed_in_resource && (signed_in_resource.email == auth.info.email)
    		user.provider = auth.provider
    		user.uid = auth.uid
    		user.fb_url = auth.extra.raw_info.link
    		user.sex = auth.extra.raw_info.gender if user.sex.nil?
    		user.first_name = auth.info.first_name if user.first_name.nil?
    		user.last_name = auth.info.last_name if user.last_name.nil?
    		user.location = auth.info.location if user.location.nil?
    		user.birthday = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y') if user.birthday.nil?
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
