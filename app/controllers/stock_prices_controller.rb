class StockPricesController < ApplicationController
  before_action :init_client

  # GET /price?symbol=AAPL
  def price
    symbol = params[:symbol]
    if symbol.blank?
      render json: { error: "symbol parameter required" }, status: :unprocessable_entity
    else
      render json: @client.price(symbol)
    end
  end

  # GET /prices?symbols=AAPL,GOOG,MSFT
  def prices
    symbols = params[:symbols]&.split(",")
    if symbols.blank?
      render json: { error: "symbols parameter required (comma separated)" }, status: :unprocessable_entity
    else
      render json: @client.prices(symbols)
    end
  end

  # GET /price_all
  def price_all
    render json: @client.price_all
  end

  private

  def init_client
    @client = LatestStockPrice::Client.new
  end
end
