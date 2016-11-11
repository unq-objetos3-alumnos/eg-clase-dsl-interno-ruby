require_relative './Tag.rb'

#
# Dsl como "clase instanciable"
# Implementacion mas "objetosa" modelando los tags
#
class Html

	def initialize
		@root = Tag.new(:html)
	end

	def root(&block)
		@root.instance_eval(&block) unless block.nil?
		@root
	end

	def to_s
		@root.to_s
	end	

end