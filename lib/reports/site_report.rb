module Reports
    class SiteReport

        def self.get_site_from_chars(chars)
            if /\d/.match(chars)
                SITE_ARRAY.select{|el| /^#{chars}/i.match( el[0].to_s ) }
            else
                SITE_ARRAY.select{|el| /^#{chars}/i.match( el[1] ) }
            end

        end

        def self.get_array_of_sites
            return_array = []
            Site.all.each do |site|
                sub_array = [site.site_num, site.site_name, site.telephone_num]
                return_array << sub_array unless sub_array.nil?
            end
            return_array
        end

        def self.get_array_of_site_names
            return_array = []
            SITE_ARRAY.each do |site_element|
                return_array << site_element[1]
            end
            return_array.sort{|x,y| x <=> y }
        end

        SITE_ARRAY = get_array_of_sites
    end
end