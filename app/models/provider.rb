class Provider < ActiveRecord::Base
    PROVIDER_ARRAY = [["AT&T", "@txt.att.net "],
                      ["Sprint", "@messaging.sprintpcs.com"],
                      ["T-Mobile", "@tmomail.net"],
                      ["Verizon", "@vtext.com"],
                      ["Virgin", "@vmobl.com"],
                      ["Nextel", "@messaging.nextel.com"],
                      ["Cingular", "@cingularme.com"],
                      ["Boost", "@myboostmobile.com"],
                      ["Alltel", "@text.wireless.alltel.com"],
                      ["Criket", "@sms.mycricket.com"],
                      ["US-Cellular", "@email.uscc.net"],
                      ["onpage", "@onpage.com"],
                      ["American", "@pager.myairmail.com"]]

    def self.get_provider_name_from_chars(chars)
        PROVIDER_ARRAY.select{|el| /^#{chars}/i.match(el[0]) }
    end
end
