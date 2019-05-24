require('./libs/core_logger')
require('./libs/config_loader')
require('./libs/context')
require('./libs/calculator')
require('./libs/json_tools')

class Core
  attr_reader :context

  def initialize
    @context = Context.new
  end

  def run
    begin
      CoreLogger.instance.logger.info("Core - run") { "Debut" }

      context.cars_array, context.rentals_array, context.rental_modifications_array = JsonTools.instance.parse(ConfigLoader.instance.configs.json_file)

      context.output_rentals_array = Calculator.instance.calculate_rental(context.cars_array, context.rentals_array)
      JsonTools.instance.create_rentals_json_file(context.output_rentals_array)

      context.output_rental_modifications_array = Calculator.instance.calculate_rental_modifications(context.cars_array, context.rentals_array, context.rental_modifications_array)
      JsonTools.instance.create_rental_modifications_json_file(context.output_rental_modifications_array)

    rescue JsonLoaderException => e
      CoreLogger.instance.logger.error("Core - run") { "JsonLoaderException => #{e.message}"}
    rescue CalculatorException => f
      CoreLogger.instance.logger.error("Core - run") { "CalculatorException => #{f.message}"}
    rescue ContextException => g
      CoreLogger.instance.logger.error("Core - run") { "ContextException => #{g.message}"}
    rescue Exception => h
      raise h
    ensure
      CoreLogger.instance.logger.info("Core - run") { "Fin" }
    end
  end
end

ConfigLoader.instance.load
Core.new.run
