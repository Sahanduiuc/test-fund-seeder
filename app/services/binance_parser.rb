class BinanceParser
  def parse
    RequestResult.where(parsed_data: nil).find_each do |rr|
      rr.parsed_data = rr.raw_data["balances"].select do |balance|
        BigDecimal(balance["free"]) + BigDecimal(balance["locked"]) > 0
      end
      rr.save!
    end
  end
end
