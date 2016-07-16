class SimpleYamlFactory < SimpleFactory::Factory
  define File.join(File.dirname(__FILE__), 'model.yml')

  def create(params)
    Model.new(*params.values_at(:name, :age, :job))
  end
end
