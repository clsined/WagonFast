require 'singleton'
require('./libs/context')
require('./libs/output_rentals')
require('./libs/output_rental_modifications')

class Calculator
  include Singleton

  def calculate_rental(cars_array, rentals_array)
    output_rental_array = Array.new
    raise CalculatorException.new("Calculator - calculate_rental : arg 'cars_array' is nil or empty") if cars_array.nil? or cars_array.empty?
    raise CalculatorException.new("Calculator - calculate_rental : arg 'rentals_array' is nil or empty") if rentals_array.nil? or rentals_array.empty?
    rentals_array.each do |rental|
      raise CalculatorException.new("Calculator - calculate_rental : car_id in current rental not exist (verify json file)") if cars_array[rental[1].car_id].nil?
      curr_calc_rental = OutputRentals.new(rental[1].rental_id,
                                           cars_array[rental[1].car_id].price_per_day,
                                           rental[1].duration,
                                           cars_array[rental[1].car_id].price_per_km,
                                           rental[1].km,
                                           rental[1].deductible_reduction)
      output_rental_array.push(curr_calc_rental)
    end
    output_rental_array
  end

  def calculate_rental_modifications(cars_array, rentals_array, rental_modifications_array)
    output_rental_modification_array = Array.new
    raise CalculatorException.new("Calculator - calculate_rental_modification : arg 'rental_modifications_array' is nil or empty") if rental_modifications_array.nil? or rental_modifications_array.empty?
    rental_modifications_array.each do |modification|
      raise CalculatorException.new("Calculator - calculate : rental_id in current rental_modification not exist (verify json file)") if rentals_array[modification[1].rental_id].nil?
      if modification[1].start_date.nil? then
        modification[1].start_date = rentals_array[modification[1].rental_id].start_date
      end
      if modification[1].end_date.nil? then
        modification[1].end_date = rentals_array[modification[1].rental_id].end_date
      end
      if modification[1].km.nil? then
        modification[1].km = rentals_array[modification[1].rental_id].km
      end
      if modification[1].deductible_reduction.nil? then
        modification[1].deductible_reduction = rentals_array[modification[1].rental_id].deductible_reduction
      end
puts modification[1].id
      curr_calc_rental_modification = OutputRentalModifications.new(modification[1].id,
                                                                    modification[1].rental_id,
                                                                    cars_array[rentals_array[modification[1].rental_id].car_id].price_per_day,
                                                                    modification[1].duration,
                                                                    cars_array[rentals_array[modification[1].rental_id].car_id].price_per_km,
                                                                    modification[1].km,
                                                                    modification[1].deductible_reduction)
      output_rental_modification_array.push(curr_calc_rental_modification)
    end
    output_rental_modification_array
  end
end

class CalculatorException < StandardError
end
