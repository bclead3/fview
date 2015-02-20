module Parsers
    class ProviderParser

        def self.process(filename = "#{Rails.root}/data_source/Providers.txt")
            puts "the filename is:#{filename}"
            if File.exists?(filename)
                content = File.open(filename) {|f| f.read }
            else

            end
            arr = content.split("\r\n")

            transform_array(arr)
        end

        private

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