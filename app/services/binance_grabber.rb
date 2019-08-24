# frozen_string_literal: true

class BinanceGrabber
  def fetch_account
    client = Binance::Client::REST.new api_key: BINANCE_API_KEY, secret_key: BINANCE_SECRET_KEY
    client.ping
  end
end
