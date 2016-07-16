module SimpleFactory
  module ActiveRecord
    module TimeMachine
      def self.included(klass)
        klass.class_eval do
          after_create do |model, params|
            model.created_at = params[:created_at] if params.key?(:created_at)
            model.updated_at = params[:updated_at] if params.key?(:updated_at)
            model.save
          end
        end
      end
    end
  end
end
