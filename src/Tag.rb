
#
# Modela un tag con atributos y contenido.
#
class Tag
	attr_accessor :content

	def initialize(name, opts={}, content=nil)
		@name = name
		@opts = opts
		@content = content
	end

	def method_missing(m, args={}, &block)
		tag = Tag.new(m, args)

		tag.instance_eval(&block) unless block.nil?

		@content = tag
		self
	end

	def to_s
		"<#{@name}#{options}>#{@content}<\/#{@name}>"
	end

	def content
	end

	def options
		options = @opts.keys.map {|key| "#{key}=\"#{@opts[key]}\"" }.join(' ')
		options = ' ' + options if options.length > 0
	end
end