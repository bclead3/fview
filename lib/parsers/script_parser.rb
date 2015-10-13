module Parsers
    class ScriptParser
        @key_value = nil

        def self.get_vb_script_path
            #@key_value = IO.readlines( FView::Config.read_config_by_key_value( :messaging, 'vbs_script_file_path' ) ).first
            FView::Config.read_config_by_key_value( :messaging, 'vbs_script_file_path' )
        end

        def self.call_vb_script_with_input( input )

        end
    end
end