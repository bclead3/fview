require 'bigdecimal/math'

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
    end
end
