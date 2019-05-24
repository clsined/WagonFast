require('./libs/commission')
require('./libs/options')

class OutputRentals
  attr_accessor :rental_id, :price, :options, :commission

  def initialize(rental_id, price_per_days, duration, price_per_km, km, deductible_reduction)
    @rental_id = rental_id
    @price = calc_price_per_day(price_per_days, duration) + calc_price_per_distance(price_per_km, km)
    @options = Options.new(deductible_reduction, duration)
    @commission = Commission.new(@price, duration)
    CoreLogger.instance.logger.debug("OutputRentals - initialize") {"#{rental_id}, #{price_per_days}, #{duration}, #{price_per_km}, #{km}, #{commission.inspect}"}
  end

  def to_hash
    {
        rental_id: @rental_id,
        price: @price,
        options: @options.to_hash,
        commission: @commission.to_hash
    }
  end

  def inspect
    "OutputRentals(object_id: #{object_id}, id: #{rental_id}, price: #{price}, options: #{options.inspect}, commission: #{commission.inspect})"
  end

  private

  def calc_price_per_day(price_per_days, duration)
    ((price_per_days - (price_per_days * advantage(duration))) * duration).to_i
  end

  def calc_price_per_distance(price_per_km, km)
    (price_per_km * km).to_i
  end

  # price per day decreases by 10% after 1 day
  # price per day decreases by 30% after 4 days
  # price per day decreases by 50% after 10 days
  def advantage(duration)
    CoreLogger.instance.logger.info("OutputRentals - advantage") {"Determination du ratio de l'avantage du prix par jours en fonction de la duree"}
    case duration
    when 1..3
      CoreLogger.instance.logger.info("OutputRentals - advantage") {"Ratio de 10% pour une durée de #{duration} jours"}
      0.10
    when 4..9
      CoreLogger.instance.logger.info("OutputRentals - advantage") {"Ratio de 30% pour une durée de #{duration} jours"}
      0.30
    else
      CoreLogger.instance.logger.info("OutputRentals - advantage") {"Ratio de 50% pour une durée de #{duration} jours"}
      0.50
    end
  end
end
