require 'parsers/read_config'

module Messages

    class PhoneMapper
        @carrier
        @phone_val
        @on_call_person
        @on_call_array
        @processed_array

        def self.get_on_call_phone_number
            @phone_val ||= get_on_call_values[1]
        end

        def self.get_on_call_carrier
            @carrier   ||= get_on_call_values[2]
        end

        def self.get_on_call_carrier_address
            on_call_carrier = get_on_call_carrier
            return_value    = ''
            carrier_array = Parsers::ProviderParser.process
            carrier_array.each do |carrier_name, carrier_full_name, at_address|
                if on_call_carrier == carrier_name
                    return_value = at_address
                    break
                end
            end
            return_value
        end

        def self.get_on_call_person
            @on_call_person = IO.readlines( Parsers::Config.read_config_by_key_value( :messaging, 'on_call_person_file_path' ) ).first
        end

        def self.get_team_addresses
            @on_call_array = IO.readlines( Parsers::Config.read_config_by_key_value( :messaging, 'all_team_pager_addresses_file_path' ) )
        end

        def self.process_team_array
            @processed_array = []
            get_team_addresses.each do |element|
                if element.index("\t")
                    possible_split_arr = element.split("\t")
                    if possible_split_arr[0] != 'Name'
                        on_call_id = possible_split_arr[0]
                        on_call_ph = possible_split_arr[1]
                        on_call_carrier = possible_split_arr[2].gsub("\r\n",'')
                        @processed_array << [on_call_id, on_call_ph, on_call_carrier]
                    end
                else
                    # puts "no \\t for element:#{element}"
                end
            end
            @processed_array
        end

        def self.get_on_call_values
            on_call_person = get_on_call_person
            return_array = []
            process_team_array.each do |sub_array|
                if sub_array[0] == on_call_person
                    return_array = sub_array
                    break
                end
            end
            return_array
        end
    end
end