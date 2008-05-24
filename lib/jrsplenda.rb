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

def using_jtestr?
  begin
    @jtestr = Object.const_get 'JtestR'
  rescue
    @jtestr = false
  end
  @jtestr
end

load_gem 'activesupport', 'active_support'
load_gem 'mocha'


# Ola's JRuby Mocha Monkey Patch (now say that 20 times quickly)
unless using_jtestr? 
  require File.dirname(__FILE__) + "/jrsplenda/mocha/jrsplenda_mocha_support.rb"
end

# The sweetener
$LOAD_PATH << (File.dirname(__FILE__) + "/jrsplenda")
require 'jrsplenda_mock_helper'
require 'jrsplenda_field_helper'
