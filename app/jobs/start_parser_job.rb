# frozen_string_literal: true

class StartParserJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    BinanceParser.new.parse
  end
end
