# frozen_string_literal: true

class BinanceParserJob < ApplicationJob
  queue_as :parser_queue

  def perform(*_args)
    BinanceParserService.call
  end
end
