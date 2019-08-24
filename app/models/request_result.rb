class RequestResult < ApplicationRecord
  serialize :raw_data
  serialize :parsed_data
end
