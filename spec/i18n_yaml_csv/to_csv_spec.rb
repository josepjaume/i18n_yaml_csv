# coding: utf-8
require 'spec_helper'

describe I18nYamlCsv::ToCSV do
  let(:data) do
    {
      ca: {
        goodbye: "Adéu.",
        greetings: {
          formal: "Hola",
          informal: "Ep!"
        },
        ordinals: ["primer", "segon", "tercer"]
      },
      es: {
        goodbye: "Adiós.",
        greetings: {
          formal: "Hola",
          informal: "Epa!"
        },
        ordinals: ["primero", "segundo", "tercero"]
      },
      en: {
        goodbye: "Goodbye.",
        greetings: {
          formal: "Hello",
          informal: "Yo!"
        },
        ordinals: ["first", "second", "third"]
      }
    }
  end

  let(:subject) { described_class.new(data) }

  describe "generate" do
    it "converts to csv" do
      csv = CSV.parse(subject.generate)
      expect(csv.first).to eq(["code", "ca", "es", "en"])
      expect(csv).to include(
                       ["goodbye", "Adéu.", "Adiós.", "Goodbye."],
                       ["greetings.formal", "Hola", "Hola", "Hello"],
                       ["greetings.informal", "Ep!", "Epa!", "Yo!"],
                       ["ordinals[0]", "primer", "primero", "first"],
                       ["ordinals[1]", "segon", "segundo", "second"],
                       ["ordinals[2]", "tercer", "tercero", "third"]
                     )
    end
  end
end
