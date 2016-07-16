require 'spec_helper'

describe SimpleFactory::Factory do
  Model = Struct.new(:name, :age, :job)

  context 'with simple definitions' do
    subject do
      Class.new(SimpleFactory::Factory) do
        define do
          name 'Ninome Miyasaki'
          age 16
          job 'JK'
        end

        def create(params)
          Model.new(*params.values_at(:name, :age, :job))
        end
      end
    end

    describe '.create' do
      context 'with no arguments' do
        it 'creates an object with default attributes' do
          model = subject.create
          expect(model).to be_a Model
          expect(model.name).to eq 'Ninome Miyasaki'
          expect(model.age).to eq 16
          expect(model.job).to eq 'JK'
        end
      end

      context 'with arguments' do
        it 'creates an object with attributes overrided by the arguments' do
          model = subject.create(name: 'Hajime Miyasaki', age: 17, job: 'DK')
          expect(model).to be_a Model
          expect(model.name).to eq 'Hajime Miyasaki'
          expect(model.age).to eq 17
          expect(model.job).to eq 'DK'
        end
      end
    end
  end
end
