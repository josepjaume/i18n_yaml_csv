module I18nYamlCsv
  class FromCSV
    def initialize(csv)
      @csv = csv
    end

    def generate
      locales = nil
      result = {}

      CSV.parse(@csv, headers: true) do |row| 
        locales ||= row.headers - ['code']

        locales.each do |locale| 
          result[locale] ||= {}
          put_in_hash(result[locale], row.fetch('code'), row.fetch(locale))
        end
      end

      result
    end

    private

    def put_in_hash(hash, path, value)
      replace_nested_value_by(hash, path.split('.'), value)
    end

    def replace_nested_value_by(h, keys, value)
      if keys.size > 1
        h[keys.first] ||= {}
        replace_nested_value_by(h[keys.first], keys[1..-1], value)
      elsif keys.size == 1
        key = keys.first
        if match_data = /.+\[([0-9]+)\]/.match(keys.first)
          index = match_data[1].to_i
          key = key.gsub("[#{index}]", "")
          h[key] ||= []
          h[key].insert(index, value)
        else
          h[key] = value
        end
      end
    end
  end
end
