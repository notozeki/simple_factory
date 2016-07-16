require 'simple_factory/definition'
require 'simple_factory/dsl'
require 'simple_factory/factory'
require 'simple_factory/hash_definitions'
require 'simple_factory/version'

module SimpleFactory
  class << self
    attr_accessor :definitions_dir
  end
end
