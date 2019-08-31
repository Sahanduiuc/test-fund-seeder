# frozen_string_literal: true

class BinanceGrabberJob < AbstractRecurrentJob
  queue_as :grabber_queue

  def perform(*_args)
    BinanceGrabberService.call
    BinanceParserJob.perform_later
  end

  private

  def wait_period
    1.hour
  end
end
