# frozen_string_literal: true

class BinanceParserJob < AbstractRecurrentJob
  queue_as :parser_queue

  def perform(*_args)
    BinanceParserService.call
  end

  private

  def wait_period
    1.hour
  end
end
