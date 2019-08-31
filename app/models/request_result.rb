# frozen_string_literal: true

class RequestResult < ApplicationRecord
  validates :raw_data, presence: true
  validate :raw_data_must_be_a_hash
  validate :raw_data_should_contain_balances
  validate :parsed_data_must_be_an_array

  def raw_data_must_be_a_hash
    return if raw_data.is_a?(Hash)

    errors.add(
      :raw_data,
      "Must be a Hash but it is a #{raw_data.class.name}"
    )
  end

  def raw_data_should_contain_balances
    balances = raw_data.dig('balances')
    return if balances&.is_a?(Array)

    errors.add(
      :raw_data,
      'Should contains balances array'
    )
  end

  def parsed_data_must_be_an_array
    return if !parsed_data || parsed_data.is_a?(Array)

    errors.add(
      :parsed_data,
      "Must be an Array but it is a #{parsed_data.class.name}"
    )
  end

  serialize :raw_data
  serialize :parsed_data
end
