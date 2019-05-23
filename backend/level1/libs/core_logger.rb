require 'singleton'
require 'logger'
require('./libs/config_loader')

class CoreLogger
  include Singleton

  attr_reader :logger

  def initialize
    @logger = Logger.new MultiIO.new(STDOUT, File.open(ConfigLoader.instance.configs.logger_file, "a"))
    @logger.info("CoreLogger - initialize") { "Initialisation du logger, fichier '#{ConfigLoader.instance.configs.logger_file}'" }
  end
end

class MultiIO
  def initialize(*targets)
    @targets = targets
  end

  def write(*args)
    @targets.each {|t| t.write(*args)}
  end

  def close
    @targets.each(&:close)
  end
end
