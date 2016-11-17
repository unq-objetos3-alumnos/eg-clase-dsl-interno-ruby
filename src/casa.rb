#-------------Modelo-------------------
class Casa
  attr_accessor :ambientes

  def to_s
    "Una casa con \n #{ambientes.map { |amb| amb.to_s }.join("\n ")}"
  end
end

class Ambiente
  attr_accessor :amenities, :nombre

  def to_s
    "un #{nombre} con #{amenities}"
  end
end

class Amenity
  attr_accessor :descripcion
end

#----------Controller-------------

class AmbienteBuilder

  @@ambientes_permitidos = [:dormitorio, :cocina, :baño]

  def initialize

    @ambientes = []
  end

  def build
    @ambientes
  end

  def method_missing(name, *args, &block)
    raise "Ambiente inválido #{name}" unless @@ambientes_permitidos.include?(name)
    amb = Ambiente.new
    amb.nombre = name
    if block_given?
      builder = AmenitiesBuilder.new
      builder.instance_eval &block
      amb.amenities = builder.build
    end
    @ambientes << amb
    amb
  end
end

class AmenitiesBuilder
  def build
    @amenities
  end

  def initialize
    @amenities = []
  end

  def con(algo)
    @amenities << algo
  end
end

class CasaBuilder

  def initialize
    @ambientes = []
  end

  def populate(&block)
    builder = AmbienteBuilder.new
    builder.instance_eval &block
    @ambientes = builder.build
    self
  end

  def build
    casa = Casa.new
    casa.ambientes = @ambientes
    casa
  end
end
#---------------Vista--------------

module MyDSL

  def casa(&block)
    CasaBuilder.new.populate(&block).build
  end

end

#------------------Uso-------------------
include MyDSL

una_casa = casa do
  dormitorio do
    con :placard
  end
  cocina

  baño do
    con :bañera
  end

  patio
end
puts una_casa
