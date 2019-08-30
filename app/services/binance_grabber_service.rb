# frozen_string_literal: true

class BinanceGrabberService
  attr_writer :client

  def self.call
    new.call
  end

  def call
    account = client.account_info
    RequestResult.transaction do
      record = RequestResult.lock.last
      if record.blank? || record.raw_data['updateTime'] != account['updateTime']
        rr = RequestResult.create!(raw_data: account)
        logger.info("#{self.class.name} fetched account RequestResult.id = #{rr.id} from #{@client}")
      end
    end
  end

  private

  def logger
    Delayed::Worker.logger
  end

  def client
    unless @client
      @client = Binance::Client::REST.new(
        api_key: BINANCE_API_KEY,
        secret_key: BINANCE_SECRET_KEY
      )
      logger.info("#{self.class.name} created new #{@client}")
    end
    @client
  end
end
