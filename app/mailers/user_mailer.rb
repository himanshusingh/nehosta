class UserMailer < ActionMailer::Base
  default from: "support@nehosta.com"

  def welcome_email(user)
  	@user = user
  	mail to: @user.email, subject: "Welcome to Nehosta"
  end
end
