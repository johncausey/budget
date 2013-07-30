class MessageMailer < ActionMailer::Base
  default from: "message@rainybudget.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #

  def send_customer_message(message)
    @message = message
    mail :to => "support@rainybudget.com", :subject => "New Message from rainybudget.com - #{Time.zone.now.strftime("%b %d, %Y")}"
  end

end
