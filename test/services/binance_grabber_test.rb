# frozen_string_literal: true

require 'test_helper'

ANOTHER_UPDATE_TIME = '9999999999999'

def change_update_time
  # FIXME: replace change time in DB on change time in stub service response
  r = RequestResult.all.last
  r.raw_data['updateTime'] = ANOTHER_UPDATE_TIME
  r.save!
end

class BinanceGrabberTest < ActiveSupport::TestCase
  test "Grabber should save new record if 'updateTime' of account was changed" do
    grabber = BinanceGrabber.new
    grabber.fetch_account
    change_update_time
    grabber.fetch_account
    assert_equal 2, RequestResult.all.count
  end

  test "Grabber should'nt save new record if 'updateTime' of account was not changed" do
    grabber = BinanceGrabber.new
    grabber.fetch_account
    grabber.fetch_account
    assert_equal 1, RequestResult.all.count
  end
end
