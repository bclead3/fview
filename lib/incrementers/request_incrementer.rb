require 'parsers/read_config'


module Incrementers
    class RequestIncrementer
        @content_array  = []
        @path           = nil

        def initialize( path = get_increment_file_path )
            puts "@path = #{path}"
            @path           = path
            @content_array  = IO.readlines( path )

            puts @content_array.inspect
        end

        def increment
            value = @content_array[0].to_i
            puts "original #{value}"
            puts RUBY_PLATFORM
            value += 1
            puts "increment#{value}"
            File.open(@path, 'w') do |file|
                file.write( value.to_s )
                file.close
            end
            value
        end

        def decrement
            value = @content_array[0].to_i
            puts "original #{value}"
            value -= 1
            puts "increment#{value}"
            File.open( @path, 'w' ) do |file|
                file.write( value.to_s )
                file.close
            end
            value
        end

        def get_increment_file_path
            Parsers::ReadConfig.read_config_by_key_value('incrementer', 'increment_file_path')
        end
    end
end