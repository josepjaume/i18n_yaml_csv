# coding: utf-8
require 'spec_helper'

describe I18nYamlCsv::FromCSV do
  let(:data) do
    """code,ca,es,en
goodbye,Adéu.,Adiós.,Goodbye.
greetings.formal,Hola,Hola,Hello
greetings.informal,Ep!,Epa!,Yo!
ordinals[0],primer,primero,first
ordinals[1],segon,segundo,second
ordinals[2],tercer,tercero,third"""
  end

  let(:subject) { described_class.new(data) }

  describe "generate" do
    it "converts to csv" do
      data = subject.generate
      expect(data["ca"]["goodbye"]).to eq("Adéu.")
      expect(data["es"]["goodbye"]).to eq("Adiós.")
      expect(data["en"]["goodbye"]).to eq("Goodbye.")
      expect(data["ca"]["greetings"]["formal"]).to eq("Hola")
      expect(data["es"]["greetings"]["formal"]).to eq("Hola")
      expect(data["en"]["greetings"]["formal"]).to eq("Hello")
      expect(data["ca"]["greetings"]["informal"]).to eq("Ep!")
      expect(data["es"]["greetings"]["informal"]).to eq("Epa!")
      expect(data["en"]["greetings"]["informal"]).to eq("Yo!")
      expect(data["ca"]["ordinals"]).to eq(['primer', 'segon', 'tercer'])
      expect(data["es"]["ordinals"]).to eq(['primero', 'segundo', 'tercero'])
      expect(data["en"]["ordinals"]).to eq(['first', 'second', 'third'])
    end
  end
end
