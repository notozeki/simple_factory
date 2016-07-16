require 'simple_factory/definition'
require 'simple_factory/dsl'

module SimpleFactory
  class Factory
    class << self
      def create(params = {})
        default_params = @definitions.map {|d| [d.name, d.value] }.to_h
        self.new.create(default_params.merge(params))
      end

      private
        def define(&block)
          dsl = DSL.new
          dsl.instance_eval(&block)
          @definitions = dsl.definitions
        end
    end
  end
end
