# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BinanceGrabberService, type: :service do
  it "Grabber should save new record if 'updateTime' of account was changed" do
    RequestResult.delete_all
    VCR.use_cassette(
      'Binance client.account_info 2 responses with different updateTime',
      match_requests_on: [],
      record: :once,
      allow_playback_repeats: true
    ) do
      BinanceGrabberService.call # updateTime: 1111111111111
      BinanceGrabberService.call # updateTime: 2222222222222
      BinanceGrabberService.call # updateTime: 2222222222222
      BinanceGrabberService.call # updateTime: 2222222222222
      BinanceGrabberService.call # updateTime: 2222222222222
    end
    expect(RequestResult.all.count).to eq(2)
  end
end
