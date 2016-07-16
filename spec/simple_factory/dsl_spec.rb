require 'spec_helper'

describe SimpleFactory::DSL do
  subject { SimpleFactory::DSL.new }

  describe '#method_missing' do
    context 'with an argument' do
      it 'creates an definition' do
        expect do
          subject.foo('bar')
        end.to change{ subject.definitions.size }.by 1
        definition = subject.definitions.last
        expect(definition.name).to eq :foo
        expect(definition.value).to eq 'bar'
      end
    end

    context 'with a block' do
      it 'creates an definition' do
        expect do
          subject.two_hundred { 100 + 100 }
        end.to change{ subject.definitions.size }.by 1
        definition = subject.definitions.last
        expect(definition.name).to eq :two_hundred
        expect(definition.value).to eq 200
      end
    end

    context 'with no arguments' do
      it 'raises ArgumentError' do
        expect do
          subject.foo
        end.to raise_error ArgumentError
      end
    end
  end
end
