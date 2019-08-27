# frozen_string_literal: true

require 'test_helper'

ANOTHER_TIME = 9_999_999_999_999

ACCOUNT_INFO = {
  'makerCommission' => 10,
  'takerCommission' => 10,
  'buyerCommission' => 0,
  'sellerCommission' => 0,
  'canTrade' => true,
  'canWithdraw' => true,
  'canDeposit' => true,
  'updateTime' => 1_545_034_863_172,
  'accountType' => 'MARGIN',
  'balances' => [
    { 'asset' => 'BTC', 'free' => '0.00000000', 'locked' => '0.00000000' },
    { 'asset' => 'ETH', 'free' => '0.02320440', 'locked' => '0.00000000' },
    { 'asset' => 'BNB', 'free' => '0.39970000', 'locked' => '0.00000000' },
    { 'asset' => 'TOMO', 'free' => '0.00000000', 'locked' => '0.00000000' }
  ]
}.freeze

class StubClient
  attr_reader :account_info

  def initialize
    @account_info = ACCOUNT_INFO.dup
  end

  def update_time=(update_time)
    @account_info['updateTime'] = update_time
  end
end

class BinanceGrabberTest < ActiveSupport::TestCase
  attr_accessor :grabber, :client
  setup do
    @grabber = BinanceGrabber.new
    @client = StubClient.new
    @grabber.client = @client
  end

  test "Grabber should save new record if 'updateTime' of account was changed" do
    grabber.fetch_account
    client.update_time = ANOTHER_TIME
    grabber.fetch_account
    assert_equal 2, RequestResult.all.count
  end

  test "Grabber should'nt save new record if 'updateTime' of account was not changed" do
    grabber.fetch_account
    grabber.fetch_account
    assert_equal 1, RequestResult.all.count
  end

  test 'Grabber should synchronize update RequestResult.last' do
    grabber.fetch_account
    client.update_time = ANOTHER_TIME
    [
      Thread.new { grabber.fetch_account },
      Thread.new { grabber.fetch_account },
      Thread.new { grabber.fetch_account }
    ].map(&:join)
    assert_equal 2, RequestResult.all.count
  end
end
