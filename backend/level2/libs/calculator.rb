require 'singleton'
require('./libs/context')
require('./libs/output_rentals')

class Calculator
  include Singleton

  def calculate(cars_array, rentals_array)
    output_rental_array = Array.new
    raise CalculatorException.new("Calculator - calculate : arg 'cars_array' is nil or empty") if cars_array.nil? or cars_array.empty?
    raise CalculatorException.new("Calculator - calculate : arg 'rentals_array' is nil or empty") if rentals_array.nil? or rentals_array.empty?
    rentals_array.each do |rental|
      raise CalculatorException.new("Calculator - calculate : car_id in current rental not exist (verify json file)") if cars_array[rental[1].car_id].nil?
      curr_calc_rental = OutputRentals.new(rental[1].id, cars_array[rental[1].car_id].price_per_day, rental[1].duration, cars_array[rental[1].car_id].price_per_km, rental[1].km)
      output_rental_array.push(curr_calc_rental)
    end
    output_rental_array
  end
end

class CalculatorException < StandardError
end
