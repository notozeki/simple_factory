module SimpleFactory
  class Definition
    attr_reader :name

    def initialize(name, value_or_callable)
      @name = name
      @value_or_callable = value_or_callable
    end

    def value
      if @value_or_callable.respond_to?(:call)
        @value_or_callable.call
      else
        @value_or_callable
      end
    end
  end
end
