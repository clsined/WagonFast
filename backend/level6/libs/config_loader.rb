require 'singleton'
require 'yaml'

class ConfigLoader
  include Singleton

  attr_accessor :configs, :is_loaded, :config_file

  def initialize
    @is_loaded = false
    @config_file = './conf/config.yml'
  end

  def configs
    unless ConfigLoader.instance.is_loaded then
      ConfigLoader.instance.load
    end
    @configs
  end

  def load
    unless @is_loaded then
      yml_conf = YAML::load_file(@config_file)
      @configs = ConfigFile.new(yml_conf['json_file'], yml_conf['rentals_json_file'], yml_conf['rental_modifications_json_file'], yml_conf['logger_file'])
      @is_loaded = true
      CoreLogger.instance.logger.info("ConfigLoader - load") { "Chargement du fichier de configuration : '#{config_file}'" }
    end
  end
end

class ConfigFile
  attr :json_file, :rentals_json_file, :rental_modifications_json_file, :logger_file

  def initialize(json_file, rentals_json_file,rental_modifications_json_file, logger_file)
    @json_file = json_file
    @rentals_json_file = rentals_json_file
    @rental_modifications_json_file = rental_modifications_json_file
    @logger_file = logger_file
  end

  def json_file
    raise ConfigLoaderException.new("ConfigLoader - json_file : Attr 'json_file' not initialized") if @json_file.nil? or @json_file.empty?
    @json_file
  end

  def rentals_json_file
    raise ConfigLoaderException.new("ConfigLoader - output_json_file : Attr 'rentals_json_file' not initialized") if @rentals_json_file.nil? or @rentals_json_file.empty?
    @rentals_json_file
  end

  def rental_modifications_json_file
    raise ConfigLoaderException.new("ConfigLoader - output_json_file : Attr 'rental_modifications_json_file' not initialized") if @rental_modifications_json_file.nil? or @rental_modifications_json_file.empty?
    @rental_modifications_json_file
  end

  def logger_file
    raise ConfigLoaderException.new("ConfigLoader - logger_file : Attr 'logger_file' not initialized") if @logger_file.nil? or @logger_file.empty?
    @logger_file
  end
end

class ConfigLoaderException < StandardError
end
