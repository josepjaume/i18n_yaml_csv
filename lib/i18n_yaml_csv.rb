require "i18n_yaml_csv/version"
require 'i18n_yaml_csv/to_csv'
require 'i18n_yaml_csv/from_csv'

module I18nYamlCsv
  def self.generate_csv(data)
    ToCSV.new(data).generate
  end

  def self.from_csv(csv)
    FromCSV.new(csv).generate
  end
end
