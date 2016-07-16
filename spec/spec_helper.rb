$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simple_factory'

# Requires support files.
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each { |f| require f }

# Requires fixtures.
Dir[File.join(File.dirname(__FILE__), 'fixtures', '**', '*.rb')].each { |f| require f }
