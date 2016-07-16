require 'spec_helper'

describe SimpleFactory::Factory do
  Model = Struct.new(:name, :age, :job, :created_at)

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

  context 'with `after_create` hook' do
    subject do
      Class.new(SimpleFactory::Factory) do
        define do
          name 'Ninome Miyasaki'
          age 16
          job 'JK'
        end

        def create(params)
          Model.new(params)
        end

        after_create do |model, params|
          model.created_at = (params[:created_at] ? params[:created_at] : Time.now)
        end
      end
    end

    describe '.create' do
      context 'without `created_at`' do
        it 'creates an object with `created_at`' do
          model = subject.create
          expect(model.created_at).to be_a Time
        end
      end

      context 'with `created_at`' do
        it 'creates an object with exact time of `created_at`' do
          created_at = Time.new(2006, 1, 2, 15, 4, 5)
          model = subject.create(created_at: created_at)
          expect(model.created_at).to eq created_at
        end
      end
    end
  end
end
