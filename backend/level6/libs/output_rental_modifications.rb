require('./libs/commission')
require('./libs/options')
require('./libs/action')
require ('./libs/output_rentals')

class OutputRentalModifications < OutputRentals
  attr_accessor :id

  def initialize(id, rental_id, price_per_days, duration, price_per_km, km, deductible_reduction)
    @id = id
    super(rental_id, price_per_days, duration, price_per_km, km, deductible_reduction)
  end

  def to_hash
    array_hash = []
    @array_action.each do |action|
      array_hash.push(action.to_hash)
    end
    final_hash = {
        id: @id,
        rental_id: @rental_id,
    actions: array_hash
    }
    final_hash
  end

  def inspect
    "OutputRentals(object_id: #{object_id}, id: #{rental_id}, #{super.inspect})"
  end
end
