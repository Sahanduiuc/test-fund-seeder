require 'test_helper'

class BinanceGrabberTest < ActiveSupport::TestCase
  test "fetch_account" do
    grabber = BinanceGrabber.new
    grabber.fetch_account
  end
end
