require "rubygems"
require "sinatra"
require 'httparty'

class NovaPoshta
  include HTTParty

  base_uri 'api.novaposhta.ua/v2.0/json'

  attr_accessor :api_key

  def initialize(api_key)
    @options = { "apiKey" => api_key, "modelName" => "Address", "calledMethod" => "getCities" }.to_json
  end

  def cities
    self.class.post("/Adress/getCities", body: @options, debug_output: $stdout)
  end

end

get '/' do
  data = NovaPoshta.new("56eef9b76e16031f1cd019a318b2abe5").cities.parsed_response["data"]
  @cities = []

  data.each do |item|
    @cities << item["DescriptionRu"]
  end

  "#{@cities.join("</br>")}"
end