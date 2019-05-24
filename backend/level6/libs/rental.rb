require 'date'

class Rental
  attr_accessor :rental_id, :car_id, :start_date, :end_date, :km, :deductible_reduction

  def initialize(rental_id, car_id, start_date, end_date, km, deductible_reduction)
    @rental_id = rental_id
    @car_id = car_id
    @start_date = start_date
    @end_date = end_date
    @km = km
    @deductible_reduction = deductible_reduction
  end

  def duration
    1 + (Date.parse(@end_date) - Date.parse(@start_date)).to_i
  end

  def inspect
    "Rental(object_id: #{object_id}, rental_id: #{rental_id}, car_id: #{car_id}, start_date: #{start_date}, end_date: #{end_date}, km: #{km})"
  end

end