class Action
  attr_accessor :who, :type, :amount

  def initialize(who, type, amount)
    @who = who
    @type = type
    @amount = amount
  end

  def to_hash
    {
        who: @who.value,
        type: @type.value,
        amount: @amount
    }
  end

  def inspect
    "Actions(who: #{who.value}, type: #{type.value}, amount: #{amount})"
  end

end

class Who
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  DRIVER = new("driver")
  OWNER = new("owner")
  INSURANCE = new("insurance")
  ASSISTANCE = new("assistance")
  DRIVY = new("drivy")

  class << self
    private :new
  end
end

class Type
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  DEBIT = new("debit")
  CREDIT = new("credit")

  class << self
    private :new
  end
end
