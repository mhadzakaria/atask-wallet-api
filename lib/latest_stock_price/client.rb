require "net/http"
require "json"
require_relative "version"

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com"

    def initialize
      @headers = {
        "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com",
        "X-RapidAPI-Key"  => ENV["RAPIDAPI_KEY"] # API key kamu taruh di ENV
      }
    end

    def price(symbol)
      get("/price?symbol=#{symbol}")
    end

    def prices(symbols)
      get("/prices?symbols=#{symbols.join(",")}")
    end

    def price_all
      get("/price_all")
    end

    private

    def get(path)
      uri = URI(BASE_URL + path)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.get(uri, @headers)
      end
      JSON.parse(response.body)
    end
  end
end
