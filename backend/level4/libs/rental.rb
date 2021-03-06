require 'date'

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :km, :deductible_reduction

  def initialize(id, car_id, start_date, end_date, km, deductible_reduction)
    @id = id
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
    "Rental(object_id: #{object_id}, id: #{id}, car_id: #{car_id}, start_date: #{start_date}, end_date: #{end_date}, km: #{km})"
  end

end