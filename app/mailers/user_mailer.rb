class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_pharmacy_request.subject
  #
  def send_pharmacy_request(number, carrier = 'verizon', message)
    @greeting = message
    @email    = SMSFu.sms_address(number, carrier)
    mail to: @email
  end
end
