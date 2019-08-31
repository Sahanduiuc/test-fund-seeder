# frozen_string_literal: true

class RequestResult < ApplicationRecord
  validates :raw_data, presence: true
  validate :raw_data_must_be_a_hash
  validate :raw_data_should_contain_balances
  validate :parsed_data_must_be_an_array

  def raw_data_must_be_a_hash
    unless raw_data.is_a?(Hash)
      errors.add(
        :raw_data,
        "Must be a Hash but it is a #{raw_data.class.name}"
      )
    end
  end

  def raw_data_should_contain_balances
    balances = raw_data.dig('balances')
    if !balances || !balances.is_a?(Array)
      errors.add(
        :raw_data,
        'Should contains balances array'
      )
    end
  end

  def parsed_data_must_be_an_array
    if parsed_data && !parsed_data.is_a?(Array)
      errors.add(
        :parsed_data,
        "Must be an Array but it is a #{parsed_data.class.name}"
      )
    end
  end

  serialize :raw_data
  serialize :parsed_data
end
