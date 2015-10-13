require 'sms_fu'
require 'pony'

module Messages
    PONY_CONFIG = {
        :via => :smtp,
        :via_options => {
            :address              => 'smtp.gmail.com',
            :port                 => '587',
            :user_name            => ENV['GMAIL_USERNAME'],
            :password             => ENV['GMAIL_PASSWORD'],
            :authentication       => :plain,
            :enable_starttls_auto => true,
            #:domain               => "75.73.189.8:3000"
            :domain               => ENV['CURRENT_DOMAIN_IP_ADDRESS'] #'10.30.93.162'  #10.3.4.10  #10.3.100.195
        }}

    class TextSender
        @sms_fu
        def self.send( phone_val, message_val )

            if !message_val.nil? && message_val.length > 0
                full_message = "Ph:#{phone_val} Msg:#{message_val}"
            else
                full_message = "Ph:#{phone_val}  no associated message"
            end
            get_sender.deliver( Messages::PhoneMapper.get_phone_number, Messages::PhoneMapper.get_carrier, full_message )
        end

        private

        def self.get_sender
            @sms_fu ||= SMSFu::Client.configure( :delivery => :pony, :pony_config => PONY_CONFIG )
        end
    end
end