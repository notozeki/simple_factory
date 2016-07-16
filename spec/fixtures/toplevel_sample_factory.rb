SimpleFactory.definitions_dir = File.join(File.dirname(__FILE__), './definitions')

class ToplevelSampleFactory < SimpleFactory::Factory
  define 'toplevel_sample.yml'

  def create(params)
    Model.new(*params.values_at(:name, :age, :job))
  end
end
