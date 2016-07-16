require 'simple_factory/definition'
require 'simple_factory/dsl'

module SimpleFactory
  class Factory
    class << self
      def create(params = {})
        default_params = @definitions.map {|d| [d.name, d.value] }.to_h
        merged_params = default_params.merge(params)
        self.new.create(merged_params).tap do |model|
          @after_create_hooks.each {|hook| hook.call(model, merged_params) }
        end
      end

      private
        def define(&block)
          dsl = DSL.new
          dsl.instance_eval(&block)
          @definitions = dsl.definitions
        end

        def after_create(&block)
          @after_create_hooks << block
        end

        def inherited(subclass)
          subclass.class_eval do
            @after_create_hooks = []
          end
        end
    end
  end
end
