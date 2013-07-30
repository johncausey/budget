class UserMailer < ActionMailer::Base
  default from: "support@rainybudget.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #

  def new_user_signup(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to rainybudget.com!"
  end

  def new_user_notify_admin(user)
    @user = user
    mail :to => "support@rainybudget.com", :subject => "New user signup at rainybudget.com - #{Time.zone.now.strftime("%b %d, %Y")}"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset Instructions - rainybudget.com - #{Time.zone.now.strftime("%b %d, %Y")}"
  end
  
end
