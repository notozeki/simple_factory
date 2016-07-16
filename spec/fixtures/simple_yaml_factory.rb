SimpleFactory.definitions_dir = File.join(File.dirname(__FILE__), './definitions')

class SimpleYamlFactory < SimpleFactory::Factory
  define 'simple_yaml.yml'

  def create(params)
    Model.new(*params.values_at(:name, :age, :job))
  end
end
