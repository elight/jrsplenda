$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

def load_gem(gem_name, main_src = gem_name)
  begin
    require main_src
  rescue LoadError
    require 'rubygems'
    gem gem_name
    require main_src
  end
end

load_gem 'activesupport', 'active_support'
load_gem 'mocha'

# Ola's JRuby Mocha Monkey Patch (now say that 20 times quickly)
require 'mocha/mocha_support'