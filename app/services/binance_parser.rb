# frozen_string_literal: true

class BinanceParser
  def parse
    RequestResult.where(parsed_data: nil).find_each do |rr|
      rr.parsed_data = rr.raw_data['balances'].select do |balance|
        (BigDecimal(balance['free']) + BigDecimal(balance['locked'])).positive?
      end
      rr.save!
      logger.info("#{self.class.name} parsed #{rr.parsed_data.count} balances RequestResult.id = #{rr.id}")
    end
  end

  private

  def logger
    Delayed::Worker.logger
  end
end
