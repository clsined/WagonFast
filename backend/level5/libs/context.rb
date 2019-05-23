class Context

  attr_writer :cars_array, :rentals_array, :output_rentals_array

  def initialize;
    @cars_array = []
    @rentals_array = []
    @output_rentals_array = []
  end

  def cars_array
    raise ContextException.new "Context - cars_array : Attr 'cars_array'  is empty" if @cars_array.empty?
    @cars_array
  end

  def rentals_array
    raise ContextException.new "Context - rentals_array : Attr 'rentals_array' is empty" if @rentals_array.empty?
    @rentals_array
  end

  def output_rentals_array
    raise ContextException.new "Context - output_rentals_array : Attr 'output_rentals_array' is empty" if @output_rentals_array.empty?
    @output_rentals_array
  end

  def inspect
    "Context(object_id: #{object_id}, cars_array: #{cars_array}, rentals_array: #{rentals_array}, output_rentals_array : #{output_rentals_array})"
  end

end

class ContextException < StandardError
end
