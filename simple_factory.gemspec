# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_factory/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_factory'
  spec.version       = SimpleFactory::VERSION
  spec.authors       = ['notozeki']
  spec.email         = ['notozeki@gmail.com']

  spec.summary       = 'A simple test data generator.'
  spec.homepage      = 'https://github.com/notozeki/simple_factory'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.10'
  spec.add_development_dependency 'activerecord', '~> 5.0.0'
  spec.add_development_dependency 'trailblazer', '~> 1.1.1'
  spec.add_development_dependency 'reform', '~> 2.2.1'
  spec.add_development_dependency 'dry-validation', '~> 0.8.0'
end
