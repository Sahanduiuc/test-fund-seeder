# frozen_string_literal: true

class BinanceGrabber
  def fetch_account
    client = Binance::Client::REST.new(
      api_key: BINANCE_API_KEY,
      secret_key: BINANCE_SECRET_KEY
    )
    account = client.account_info
    RequestResult.transaction do
      # Lock the last record for consistency
      # purposes when more than one grabber runs
      record = RequestResult.lock.last
      if record.blank? || record.raw_data['updateTime'] != account['updateTime']
        RequestResult.create!(raw_data: account)
      end
    end
  end
end
