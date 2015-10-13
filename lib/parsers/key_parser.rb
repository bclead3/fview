<<<<<<< HEAD
require 'fview/config'
=======
require 'parsers/read_config'
>>>>>>> cdcafd1977853d9774320c12e5caf8b9a1c52710

module Parsers
    class KeyParser
        @key_value = nil

        def self.get_key
            @key_value = IO.readlines( Parsers::Config.read_config_by_key_value( :messaging, 'key_file_path' ) ).first
        end
    end
end