module Utils
    class Loader
        def initialize
            arr = Parsers::ProviderParser.process
            arr.each do |name, full_name, email_extension|
                puts "#{name} #{full_name}\t#{email_extension}"
                begin
                    provider = Provider.find_or_create_by(name: name)
                    provider.full_name = full_name
                    provider.email = email_extension
                    provider.save!
                    puts provider.inspect
                rescue Exception => ex

                end
            end

            site_array = Parsers::SiteParser.process
            begin
                site_array.each do |site|
                    puts "#{site.site_num.to_s.ljust(4,' ')}#{site.site_name.ljust(35,' ')}#{site.telephone_num}"
                end
            rescue Exception=>exx

            end
        end
    end
end