require 'trailblazer'
require 'trailblazer/operation/model'
require 'reform/form/dry'

Reform::Form.send(:feature, Reform::Form::Dry)

require_relative './factories'

class Category
  class Create < Trailblazer::Operation
    include Model
    model Category, :create

    contract do
      property :name
    end

    def process(params)
      validate(params[:category]) do |form|
        form.save
      end
    end
  end
end
