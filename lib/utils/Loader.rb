module Utils
    class Loader
        def initialize
            arr = Parsers::ProviderParser.process
            arr.each do |name, full_name, email_extension|
                puts "#{name} #{full_name}\t#{email_extension}"
                provider = Provider.find_or_create_by(name: name)
                provider.full_name = full_name
                provider.email = email_extension
                provider.save!
                puts provider.inspect
            end
        end
    end
end