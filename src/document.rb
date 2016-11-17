module EjemploEnClase
  class Documento
    attr_accessor :root
  end

  class Tag
    attr_accessor :nombre, :atributos, :content
    def initialize
      @atributos = {}
      @content = []
    end
  end

#-------------------------

  class TagBuilder


  end

#-------------------------

  module Document
    def document(&block)

    end
  end


#--------------------------
  include Document



# document do
#    html {
#      body {
#         div {
#
#
#         }
#      }
#    }
#
#
# end
end
