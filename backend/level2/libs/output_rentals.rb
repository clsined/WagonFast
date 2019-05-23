class OutputRentals
  attr_accessor :id, :price

  def initialize(rental_id, price_per_days, duration, price_per_km, km)
    @id = rental_id
    @price = (price_per_days * duration) + (price_per_km * km)
  end

  def inspect
    "OutputRentals(object_id: #{object_id}, id: #{id}, price: #{price})"
  end

  def to_hash
    {
        id: @id,
        price: @price
    }
  end
end
