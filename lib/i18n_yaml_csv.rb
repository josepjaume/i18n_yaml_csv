require "i18n_yaml_csv/version"
require 'i18n_yaml_csv/to_csv'

module I18nYamlCsv
  def self.generate_csv(data)
    ToCSV.new(data).generate
  end
end
