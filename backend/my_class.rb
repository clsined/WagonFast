class MyClass
  # Declaration attributs et generation auto des getter
  attr_reader :x, :y

  # Declaration attributs et generation auto des setter
  attr_writer :a, :b

  # Declaration attributs et generation auto des getter et setter
  attr_accessor :attr1, :attr2

  # constructeur
  def initialize (var)
    # @ : variable d'instance
    @var = var
  end

  # getter
  def var
    @var
  end

  # setter
  def var=(var)
    @var = var
  end

end