require 'singleton'
require 'json'
require('./libs/context')
require('./libs/rental')
require('./libs/car')
require 'date'

# JsonLoader
class JsonTools
  include Singleton

  # Parse json file to array obj
  def parse(json_file)
    CoreLogger.instance.logger.info("JsonTools - parse") { "Parsing du fichier '#{json_file}'" }
    cars_array = nil
    rentals_array = nil
    begin
      # Check file
      check_json_file_path(json_file)
      json_data = JSON.parse(File.read(json_file))
      # Binding json data to obj
      cars_array = json_data_cars_to_array json_data
      rentals_array = json_data_rentals_to_array json_data
    rescue JSON::ParserError => j
      CoreLogger.instance.logger.info("JsonTools - parse") { "Parsing du fichier '#{json_file}'" }
      raise JsonLoaderTechnicalException.new("JsonLoader - parse : Structural problem in json file.\nJSON::ParserError => #{j.message}")
    rescue JsonLoaderTechnicalException => t
      raise t
    rescue JsonLoaderFonctionalException => f
      raise f
    end
    return cars_array, rentals_array
  end

  def create_json_file(output_rentals_array, output_json_file)
    CoreLogger.instance.logger.info("JsonTools - create_json_file") { "Creation fichier json" }
    array_hash = []
    output_rentals_array.each do |rent|
      array_hash.push(rent.to_hash)
    end
    final_hash = {
        rentals: array_hash
    }
    CoreLogger.instance.logger.debug("JsonTools - create_json_file") { "Hash : #{final_hash}" }
    File.open(output_json_file, "w") do |file|
      out_json = JSON.pretty_generate(final_hash)
      CoreLogger.instance.logger.info("JsonTools - create_json_file") { "Fichier genere : \n#{out_json}" }
      file.write(out_json)
    end

  end

  private

  def check_json_file_path(json_file)
    CoreLogger.instance.logger.debug("JsonTools - check_json_file_path") { "Verification existante du fichier '#{json_file}'}" }
    raise JsonLoaderTechnicalException.new("JsonLoader - check_json_file_path : Json file '#{json_file}' does not exist'") if json_file.nil? or !File.exist?(json_file)
  end

  def json_data_cars_to_array(json_data)
    CoreLogger.instance.logger.debug("JsonTools - json_data_cars_to_array") { "Mapping Json data 'car' en tableau d'objet car" }
    cars_array = {}
    json_data['cars'].each do |car|
      control_json_data_car car
      cars_array[car['id']] = Car.new(car['id'], car['price_per_day'], car['price_per_km'])
    end
    cars_array
  end

  def json_data_rentals_to_array(json_data)
    CoreLogger.instance.logger.debug("JsonTools - json_data_rentals_to_array") { "Mapping Json data 'rental' en tableau d'objet rental" }
    rentals_array = {}
    json_data['rentals'].each do |rental|
      control_json_data_rental rental
      rentals_array[rental['id']] = Rental.new(rental['id'], rental['car_id'], rental['start_date'], rental['end_date'], rental['distance'])
    end
    rentals_array
  end

  def control_json_data_car(data_car)
    CoreLogger.instance.logger.debug("JsonTools - control_json_data_car") { "Controle des valeurs relative au 'car'" }
    # id
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_car : Incorrect id for car definition in json file : #{data_car}") if data_car['id'].nil? or data_car['id'] < 0
    # price_per_day
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_car : Incorrect price_per_day for car definition in json file : #{data_car}") if data_car['price_per_day'].nil? or data_car['price_per_day'] < 0
    # price_per_km
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_car : Incorrect price_per_km for car definition in json file : #{data_car}") if data_car['price_per_km'].nil? or data_car['price_per_km'] < 0
  end

  def control_json_data_rental(data_rental)
    CoreLogger.instance.logger.debug("JsonTools - control_json_data_rental") { "Controle des valeurs relative au 'rental'" }
    # id
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_rental : Incorrect id for rental definition in json file : #{data_rental}") if data_rental['id'].nil? or data_rental['id'] < 0
    # car_id
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_rental : Incorrect car_id for rental definition in json file : #{data_rental}") if data_rental['car_id'].nil? or data_rental['car_id'] < 0
    # distance
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_rental : Incorrect distance for rental definition in json file : #{data_rental}") if data_rental['distance'].nil? or data_rental['distance'] < 0
    # start_date et end_date
    begin
      stt_date = Date.parse(data_rental['start_date'])
    rescue ArgumentError
      raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_rental : Incorrect start_date for rental definition in json file : #{data_rental}")
    end
    begin
      end_date = Date.parse(data_rental['end_date'])
    rescue ArgumentError
      raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_rental : Incorrect end_date for rental definition in json file : #{data_rental}")
    end
    raise JsonLoaderFonctionalException.new("JsonLoader - control_json_data_rental : Incorrect couple start_date/end_date for rental definition in json file : #{data_rental}") if (end_date - stt_date).to_i < 0
  end
end

class JsonLoaderException < StandardError
end

class JsonLoaderFonctionalException < JsonLoaderException
end

class JsonLoaderTechnicalException < JsonLoaderException
end

