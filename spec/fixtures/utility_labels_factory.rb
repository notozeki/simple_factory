SimpleFactory.definitions_dir = File.join(File.dirname(__FILE__), './definitions')

class UtilityLabelsFactory < SimpleFactory::Factory
  define 'utility_labels.yml'

  def create(params)
    Model.new(*params.values_at(:name, :age, :job))
  end
end
