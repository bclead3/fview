module Utils
    module OS
        def self.windows?
            (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
        end

        def self.mac?
            (/darwin/ =~ RUBY_PLATFORM) != nil
        end

        def self.unix?
            !windows?
        end

        def self.linux?
            unix? and not mac?
        end

        def self.get_platform
            if windows?
                'windows'
            elsif mac?
                'osx'
            elsif lunux?
                'linux'
            else
                'unix'
            end
        end
    end
end