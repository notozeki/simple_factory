require 'spec_helper'

describe SimpleFactory::Definition do
  describe '#name' do
    subject { SimpleFactory::Definition.new(:job, 'jk') }

    it 'returns its name' do
      expect(subject.name).to eq :job
    end
  end

  describe '#value' do
    context 'with simple value' do
      subject { SimpleFactory::Definition.new(:name, 'ninome') }

      it 'returns the value' do
        expect(subject.value).to eq 'ninome'
      end
    end

    context 'with some `call`able object' do
      subject { SimpleFactory::Definition.new(:age, lambda { 2016 - 2000 }) }

      it 'returns evaluated result' do
        expect(subject.value).to eq 16
      end
    end
  end
end
