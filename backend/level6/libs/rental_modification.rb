require('./libs/rental')

class RentalModification < Rental

  attr_accessor :id

  def initialize(id, rental_id, start_date, end_date, km)
    @id = id
    super(rental_id, nil, start_date, end_date, km, nil)
  end

  def inspect
    "RentalModification(object_id: #{object_id}, id: #{id}, rental_id: #{rental_id}, start_date: #{start_date}, end_date: #{end_date}, km: #{km})"
  end
end
