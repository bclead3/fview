require 'bigdecimal/math'
require 'yaml'

module Utils
    class GenericUtils
        START_ROW = 3

        def self.get_sheet(filename, sheet_number = 1, library = 'SimpleXlsxReader')
            sheet = nil
            if library == 'SimpleXlsxReader'
                doc = SimpleXlsxReader.open(filename)
                sheet = doc.sheets[sheet_number-1]
            else
                clazz = library.constantize
                doc = clazz.new(filename)
                if sheet_number == 1
                    sheet = doc.sheet(0)
                else
                    sheet = doc.sheet(sheet_number-1)
                end
            end
            sheet
        end
        #
        # def self.read_config_by_key_value( file_name_sym, key_value )
        #     file_path = "#{Rails.root.to_s}/config/#{file_name_sym.to_s}.yml"
        #     config = YAML.load_file(file_path)[Rails.env]
        #     config[key_value][Utils::OS.get_platform]
        # end
    end
end
