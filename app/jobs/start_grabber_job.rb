class StartGrabberJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    BinanceGrabber.new.fetch_account
  end
end
