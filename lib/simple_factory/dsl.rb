require 'simple_factory/definition'

module SimpleFactory
  class DSL
    attr_reader :definitions

    def initialize
      @definitions = []
    end

    def method_missing(name, *args, &block)
      unless args.size >= 1 || block
        raise ArgumentError, 'an argument or a block is required'
      end
      @definitions << Definition.new(name, (args.size >= 1 ? args.first : block))
    end
  end
end
