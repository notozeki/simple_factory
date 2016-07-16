require 'spec_helper'

require 'simple_factory/active_record/time_machine'

describe SimpleFactory::ActiveRecord::TimeMachine do
  subject do
    Class.new(SimpleFactory::Factory) do
      include SimpleFactory::ActiveRecord::TimeMachine

      define do
        name 'foobar'
      end

      def create(params)
        Category::Create.(category: params).model
      end
    end
  end

  it 'updates `created_at` or `updated_at` when passed them as params' do
    created_at = Time.new(2016, 7, 16, 0, 0, 0)
    updated_at = Time.new(2016, 7, 17, 12, 0, 0)
    model = subject.create(created_at: created_at, updated_at: updated_at)
    expect(model.created_at).to eq created_at
    expect(model.updated_at).to eq updated_at
  end
end
