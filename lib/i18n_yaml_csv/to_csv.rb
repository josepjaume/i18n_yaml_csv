require 'csv'

module I18nYamlCsv
  class ToCSV
    def initialize(data)
      @data = data
    end

    def generate
      headers = ["code"] + locales
      data = from_hashes([], locales.map{ |l| @data[l] })

      CSV.generate(write_headers: true, headers: headers) do |csv| 
        data.each do |row| 
          csv << row
        end
      end
    end

    def locales
      @locales ||= @data.keys
    end

    private

    def from_hashes(path, hashes)
      reference = hashes.first

      reference.flat_map do |key, value| 
        new_path = path + [key]
        values = hashes.map{ |h| h[key] }

        if value.kind_of? Hash
          next from_hashes(new_path, values)
        end

        if value.kind_of? String
          next from_strings(new_path, values)
        end

        if value.kind_of? Array
          next from_arrays(new_path, values)
        end
      end
    end

    def from_arrays(path, arrays)
      arrays.first.each_with_index.map do |value, index| 
        [path.join(".") + "[#{index}]"] + arrays.map{ |a| a[index] }
      end
    end

    def from_strings(path, strings)
      [[path.join(".")] + strings]
    end
  end
end
