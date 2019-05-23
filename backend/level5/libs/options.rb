class Options
  attr_accessor :deductible_reduction

  def initialize(deductible_reduction, duration)
    CoreLogger.instance.logger.debug("Options - initialize") { "#{deductible_reduction.class}" }
    @deductible_reduction = 0
    if deductible_reduction.is_a?(TrueClass) then
      CoreLogger.instance.logger.debug("Options - initialize") { "Reduction de franchise detecté" }
      @deductible_reduction = 4 * duration
    end
  end

  def to_hash
    {
        deductible_reduction: @deductible_reduction
    }
  end

  def inspect
    "Options(deductible_reduction: #{deductible_reduction})"
  end

end
