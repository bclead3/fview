require 'erb'
require 'utils/os'

module Parsers
    module ReadConfig
        def self.read_config
            args        = {}
            return_hash = {}
            args[:root] ||= ( defined?( Rails.root ) && Rails.root )   || ( defined?( settings ) && settings.root ) || './'
            args[:env]  ||= ( defined?( environment ) && environment ) || ( defined?( settings ) && settings.environment ) || ENV['RACK_ENV'] || 'test'

            build_path_template = File.join( args[:root], 'config', '*.yml' )
            yml_file_array      = Dir.glob( build_path_template )
            yml_file_array.each do | file_path |
                key_sym = get_base_name( file_path ).to_sym
                return_hash[key_sym] = YAML::load( ERB.new( File.new( file_path ).read ).result )
            end

            return_hash
        end

        def self.get_base_name( str )
            match_obj = /((\w*)(\.yml))/.match( str )
            match_obj[2]
        end

        def self.read_config_by_key_value( yaml_file_name, key_name )
            read_config[yaml_file_name.to_sym][Rails.env][key_name][Utils::OS.get_platform]
        end
    end
end