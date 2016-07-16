require 'simple_factory/definition'

module SimpleFactory
  class HashDefinitions
    attr_reader :samples

    def initialize(hash)
      if (samples = (hash[:_sample] || hash['_sample']))
        @samples = samples.map {|sample| parse_attrs(sample) }
      else
        @samples = [parse_attrs(hash)]
      end
    end

    private
      def parse_attrs(hash)
        hash.map do |name, value|
          Definition.new(name.to_sym, parse_value(value))
        end
      end

      def parse_value(value)
        case value
        when Hash
          parse_hash_value(value)
        else
          value
        end
      end

      def parse_hash_value(value)
        if (samples = value[:_sample] || value['_sample'])
          unless Array === samples
            raise TypeError, "`_sample`'s value must be an Array"
          end
          lambda { samples.sample }
        elsif (sequence = value[:_sequence] || value['_sequence'])
          seq = Sequence.new
          lambda { sequence.gsub(/%{i}/, seq.next.to_s) }
        else
          value
        end
      end
  end

  class Sequence
    def initialize
      @seq = 0
    end

    def next
      @seq += 1
    end
  end
end
