 class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if current_user
    	if @user != current_user
    		flash[:notice] = "This account is already being used with another account. To use this please remove the other one."
    	else
    		flash[:success] = "Successfully connected your Facebook account."
    	end
    	redirect_to current_user
    elsif @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      redirect_to cancel_user_registration_path
    end
  end
end