require 'spec_helper'

describe SimpleFactory::HashDefinitions do
  context 'with simple definition' do
    subject do
      SimpleFactory::HashDefinitions.new(
        'name' => 'Ninome Miyasaki',
        'age' => 16,
        'job' => 'JK',
      )
    end

    describe '#samples' do
      it 'returns an array of definition' do
        expect(subject.samples.size).to eq 1

        definitions = subject.samples.first

        expect(definitions[0].name).to eq :name
        expect(definitions[0].value).to eq 'Ninome Miyasaki'

        expect(definitions[1].name).to eq :age
        expect(definitions[1].value).to eq 16

        expect(definitions[2].name).to eq :job
        expect(definitions[2].value).to eq 'JK'
      end
    end
  end

  context 'with utility labels' do
    subject do
      SimpleFactory::HashDefinitions.new(
        'name' => {
          '_sample' => [
            'John Lennon',
            'Paul McCartney',
            'George Harrison',
            'Ringo Starr',
          ]
        },
        'age' => {
          '_sequence' => '%{i}歳'
        },
        'job' => 'Musician',
      )
    end

    describe '#samples' do
      it 'returns an array of definitions' do
        expect(subject.samples.size).to eq 1

        definitions = subject.samples.first

        expect(definitions[0].name).to eq :name
        expect([
          'John Lennon',
          'Paul McCartney',
          'George Harrison',
          'Ringo Starr',
        ]).to be_include definitions[0].value

        expect(definitions[1].name).to eq :age
        expect(definitions[1].value).to eq '1歳'
        expect(definitions[1].value).to eq '2歳'
        expect(definitions[1].value).to eq '3歳'

        expect(definitions[2].name).to eq :job
        expect(definitions[2].value).to eq 'Musician'
      end
    end
  end

  context 'with top-level `_sample`' do
    subject do
      SimpleFactory::HashDefinitions.new(
        '_sample' => [
          {
            'name' => 'Ninome Miyasaki',
            'age' => 16,
            'job' => 'JK',
          },
          {
            'name' => 'Hajime Miyasaki',
            'age' => 17,
            'job' => {
              '_sample' => ['A', 'B', 'C'],
            },
          },
        ]
      )
    end

    describe '#samples' do
      it 'returns multiple array of definitions' do
        expect(subject.samples.size).to eq 2

        definitions0 = subject.samples[0]

        expect(definitions0[0].name).to eq :name
        expect(definitions0[0].value).to eq 'Ninome Miyasaki'

        expect(definitions0[1].name).to eq :age
        expect(definitions0[1].value).to eq 16

        expect(definitions0[2].name).to eq :job
        expect(definitions0[2].value).to eq 'JK'

        definitions1 = subject.samples[1]

        expect(definitions1[0].name).to eq :name
        expect(definitions1[0].value).to eq 'Hajime Miyasaki'

        expect(definitions1[1].name).to eq :age
        expect(definitions1[1].value).to eq 17

        expect(definitions1[2].name).to eq :job
        expect(['A', 'B', 'C']).to be_include definitions1[2].value
      end
    end
  end
end
