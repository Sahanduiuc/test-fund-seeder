# frozen_string_literal: true

class ParserJob < AbstractRecurrentJob
  queue_as :parser_queue

  def perform(*_args)
    BinanceParser.new.parse
  end

  private

  def wait_period
    1.hour
  end
end
