# frozen_string_literal: true

class BinanceGrabber
  attr_writer :client

  def fetch_account
    account = client.account_info
    RequestResult.transaction do
      record = RequestResult.lock.last
      if record.blank? || record.raw_data['updateTime'] != account['updateTime']
        RequestResult.create!(raw_data: account)
      end
    end
  end

  private

  def client
    @client ||= Binance::Client::REST.new(
      api_key: BINANCE_API_KEY,
      secret_key: BINANCE_SECRET_KEY
    )
  end
end
