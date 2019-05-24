class Context

  attr_accessor :cars_array, :rentals_array, :rental_modifications_array, :output_rentals_array, :output_rental_modifications_array

  def initialize
    @cars_array = []
    @rentals_array = []
    @rental_modifications_array = []
    @output_rentals_array = []
    @output_rental_modifications_array = []
  end

  def inspect
    "Context(object_id: #{object_id}, cars_array: #{cars_array}, rentals_array: #{rentals_array}, rental_modifications_array: #{rental_modifications_array}, output_rentals_array : #{output_rentals_array}, output_rental_modifications_array: #{output_rental_modifications_array})"
  end
end

class ContextException < StandardError
end
