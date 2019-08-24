# frozen_string_literal: true

class BinanceGrabber
  def fetch_account
    client = Binance::Client::REST.new api_key: BINANCE_API_KEY, secret_key: BINANCE_SECRET_KEY
    account_info = client.account_info
    result = RequestResult.order(:id).last
    if result.blank? || account_info['updateTime'] != result.raw_data['updateTime']
      RequestResult.create!(raw_data: account_info)
    end
  end
end
