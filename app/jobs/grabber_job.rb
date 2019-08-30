# frozen_string_literal: true

class GrabberJob < AbstractRecurrentJob
  queue_as :grabber_queue

  def perform(*_args)
    BinanceGrabberService.new.fetch_account
  end

  private

  def wait_period
    1.hour
  end
end
