module Parsers
    class ProviderParser

        def self.process(filename = File.join(Rails.root,'config','sms_fu.yml') )
            puts "the filename is:#{filename}"
            if File.exists?(filename)
                content = YAML.load_file(filename)
            end

            process_hash_to_array(content)
        end

        private

        def self.process_hash_to_array(hash)
            new_array = []
            hash['carriers'].each do |key, value|
                carrier_name    = key
                full_name       = value['name']
                carrier_postfix = value['value']
                new_array << [carrier_name, full_name, carrier_postfix]
            end
            new_array
        end

        def self.transform_array(array)
            new_array = []
            array.shift if /Provider/.match(array[0])
            array.shift if /-+/.match(array[0])
            array.each do |element|
                sub_array = element.split("\t")
                new_array << sub_array
            end
            new_array
        end
    end
end
