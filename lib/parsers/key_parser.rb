require 'fview/config'

module Parsers
    class KeyParser
        @key_value = nil

        def self.get_key
            @key_value = IO.readlines( FView::Config.read_config_by_key_value( :messaging, 'key_file_path' ) ).first
        end
    end
end