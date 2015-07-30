require 'erb'

module FView
    module Config
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
    end
end