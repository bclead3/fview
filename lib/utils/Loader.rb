module Utils
    class Loader
        def initialize
            arr = Parsers::ProviderParser.process
            arr.each do |name, full_name, email_extension|
                provider = Provider
            end
        end
    end
end