require 'sms_fu'
require 'pony'
require 'parsers/read_config'
require 'incrementers/request_incrementer'
require 'open3'

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
            :domain               => ENV['CURRENT_DOMAIN_IP_ADDRESS'] #'10.30.93.162'  #10.3.4.10  #10.3.100.195 #10.3.100.195 #10.3.4.184
        }}

    class TextSender
        @sms_fu
        def self.send( phone_val, message_val, increment_value = Incrementers::RequestIncrementer.new.increment )

            if Utils::OS.get_platform == 'windows'
                send_on_windows( phone_val, message_val, increment_value )
            else
                if !message_val.nil? && message_val.length > 0
                    full_message = "Ph:#{phone_val} Ref\#:#{increment_value} Msg:#{message_val}"
                else
                    full_message = "Ph:#{phone_val} Ref\#:#{increment_value} no associated message"
                end
                on_call_phone   = Messages::PhoneMapper.get_on_call_phone_number
                carrier_name    = Messages::PhoneMapper.get_on_call_carrier

                get_sender.deliver( on_call_phone, carrier_name, full_message )
            end

        end

        def self.send_on_windows( phone_val, message_val = nil, increment_value = Incrementers::RequestIncrementer.new.increment )

            if phone_val && phone_val.length == 10
                send_message_vbs_path   = Parsers::ScriptParser.get_vb_script_path
                username                = Messages::PhoneMapper.get_on_call_person
                cell_number             = Messages::PhoneMapper.get_on_call_phone_number
                pager_address           = Messages::PhoneMapper.get_on_call_carrier_address
                user_phone_number       = phone_val
                if message_val
                    user_message        = "ph:#{phone_val} ref\##{increment_value} msg:#{message_val}"
                else
                    user_message        = "ph:#{phone_val} ref\##{increment_value} no associated message"
                end
                on_call_person          = Messages::PhoneMapper.get_on_call_person
                key_value               = Parsers::KeyParser.get_key

                # cscript "Q:\System-Shares\Pharmacy\SHAREDIR\Retail Pharmacy Info\site scripts\Pager app\SendPageMessage.vbs" /a: "%username%" "%CellNumber%%PagerAddress%" "%Message1%" "%NameToPage%"
                # cscript "%MyPath%\SendPageMessage.vbs" /a: "%username%" "%CellNumber%%PagerAddress%" "%PhoneNumber% Message: %Message%" "%OnCallPerson%" "%Key%"
                # cscript "%MyPath%\SendPageMessageV2.vbs" /a: "%username%" "%OnCallPerson%@fairview.org" "%OnCallPerson%" "%Key% !pagecount!" "!MyMessage!"
                total_message = "cscript #{send_message_vbs_path} /a: #{username} #{cell_number}#{pager_address} #{on_call_person} #{key_value} #{increment_value} \"#{user_message}\""
                Open3.popen3( total_message )
            else
                puts "inadequate phone value submitted"
            end
        end

        private

        def self.get_sender
            @sms_fu ||= SMSFu::Client.configure( :delivery => :pony, :pony_config => PONY_CONFIG )
        end
    end
end