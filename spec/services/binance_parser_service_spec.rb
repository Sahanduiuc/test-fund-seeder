# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BinanceParserService, type: :service do
  let(:request_result_grabbed_1) do
    RequestResult.create(
      raw_data: {'balances' => balances}
    )
  end

  let(:request_result_grabbed_2) do
    RequestResult.create(
      raw_data: {'balances' => balances}
    )
  end

  let(:request_result_parsed_3) do
    RequestResult.create(
      raw_data: {'balances' => balances},
      parsed_data: previously_parsed_balances)
  end

  let(:balances) do
    [
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
  end

  let(:not_empty_balances) do
    balances[0..1]
  end

  let(:previously_parsed_balances) do
    [
      'previously parsed balances'
    ]
  end

  subject { BinanceParserService.call }

  it 'Parser should save balances array only but without zero values' do
    request_result_grabbed_1.reload
    request_result_grabbed_2.reload
    subject
    request_result_grabbed_1.reload
    request_result_grabbed_2.reload
    expect(request_result_grabbed_1.parsed_data).to eq(not_empty_balances)
    expect(request_result_grabbed_2.parsed_data).to eq(not_empty_balances)
  end

  it 'Parser should parse only non-parser RequestResult records' do
    request_result_parsed_3.reload
    subject
    request_result_parsed_3.reload
    expect(request_result_parsed_3.parsed_data).to eq(previously_parsed_balances)
  end
end
