# frozen_string_literal: true

require 'test_helper'

BALANCES = [
  {
    'asset' => 'BTC',
    'free' => '4723846.89208129',
    'locked' => '0.00000000'
  },
  {
    'asset' => 'LTC',
    'free' => '4763368.68006011',
    'locked' => '0.00000000'
  },
  {
    'asset' => 'XXX',
    'free' => '0.00000000',
    'locked' => '0.00000000'
  }
].freeze

class BinanceParserServiceTest < ActiveSupport::TestCase
  # - [ ] Parser should parse only non-parser RequestResult records.
  test 'It should save balances array only but without zero values' do
    parser = BinanceParserService.new
    rr1 = RequestResult.create(raw_data: { 'balances' => BALANCES })
    rr2 = RequestResult.create(raw_data: { 'balances' => BALANCES })
    parser.parse
    rr1.reload
    rr2.reload
    assert_equal BALANCES[0..1], rr1.parsed_data, "parsed_data can't contains zero values"
    assert_equal BALANCES[0..1], rr2.parsed_data, "parsed_data can't contains zero values"
  end

  test 'Parser should parse only non-parser RequestResult records' do
    parser = BinanceParserService.new
    rr = RequestResult.create(raw_data: { 'balances' => BALANCES }, parsed_data: BALANCES)
    parser.parse
    rr.reload
    assert_equal BALANCES, rr.parsed_data, 'parsed_data should not be updated'
  end
end
