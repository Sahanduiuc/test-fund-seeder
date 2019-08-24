# frozen_string_literal: true

class RequestResult < ApplicationRecord
  serialize :raw_data
  serialize :parsed_data
end
