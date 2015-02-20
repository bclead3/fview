module Parsers
    class SiteParser
        DEFAULT_SHEET_POSITION = 1
        START_ROW = 2

        def self.process(filename = '')
            filename = "#{Rails.root}/data_source/Sites.xlsx"
            puts "filename is:#{filename}"
            sheet = Utils::GenericUtils.get_sheet(filename, DEFAULT_SHEET_POSITION)
            total_rows = sheet.rows.count

            (START_ROW..total_rows).each do |row_number|
                row_array = sheet.rows[row_number]

                unless row_array.nil? || row_array[0].to_s == '0'
                    site_num        = row_array[0]
                    site_name       = row_array[1]
                    telephone_num   = row_array[2]

                    #puts "#{row_array[0]}  #{row_array[1]} #{row_array[2]}"
                    site = Site.where(site_num: site_num).first
                    if site.nil?
                        site          = Site.new
                        site.site_num = site_num
                    end
                    site.site_name      = site_name
                    site.telephone_num  = telephone_num
                    site.save!
                end
            end
        end
    end
end