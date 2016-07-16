require 'spec_helper'

require 'yaml'

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

  context 'with definitions in YAML file' do
    context 'with simple definitions' do
      subject { SimpleYamlFactory }

      let(:source) do
        YAML.load_file(File.join(File.dirname(__FILE__), '../fixtures/simple_yaml/model.yml'))
      end

      it 'creates an object with params in YAML file' do
        model = subject.create
        expect(model.name).to eq source['name']
        expect(model.age).to eq source['age']
        expect(model.job).to eq source['job']
      end
    end

    context 'with utility labels' do
      subject { UtilityLabelsFactory }

      let(:source) do
        YAML.load_file(File.join(File.dirname(__FILE__), '../fixtures/utility_labels/model.yml'))
      end

      describe '.create' do
        it 'creates an object with params generated by utilities' do
          model = subject.create
          expect(source['name']['_sample']).to be_include model.name
          expect(model.age).to match /[0-9]+歳/
          expect(model.job).to eq source['job']
        end
      end
    end

    context 'with top-level `_sample`' do
      subject { ToplevelSampleFactory }

      let(:source) do
        YAML.load_file(File.join(File.dirname(__FILE__), '../fixtures/toplevel_sample/model.yml'))
      end

      describe '.create' do
        it 'creates an object with either params of `_sample` section in YAML file' do
          model = subject.create
          actual = { 'name' => model.name, 'age' => model.age, 'job' => model.job }
          expect(source['_sample']).to be_include actual
        end
      end
    end
  end
end
