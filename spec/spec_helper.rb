require File.dirname(__FILE__) + "/../lib/jrsplenda.rb"

require File.dirname(__FILE__) + "/../build/jrsplenda-fixtures.jar"

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

include Java
