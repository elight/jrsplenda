## This normally goes in a spec_helper.rb

require 'rubygems'
require 'jrsplenda'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

## 

import 'fake.DoStuff'    

describe 'Doing stuff' do
  include JRSplenda::MethodHelper
  include JRSplenda::FieldHelper
  include JRSplenda::MockHelper

  before(:each) do
    splenda_mock_attr 'fake.HasPublicMethod', :store_in => 'private_mock'
    splenda_mock_attr 'fake.HasPublicMethod', :store_in => 'protected_mock'
    splenda_mock_attr 'fake.HasPublicMethod', :store_in => 'package_mock'        

    @do_stuff = DoStuff.new
    wrap_java_fields @do_stuff
    wrap_java_methods @do_stuff
    @do_stuff.private_has_public_method = @private_mock
    @do_stuff.protected_has_public_method = @protected_mock
    @do_stuff.package_has_public_method = @package_mock
    @private_mock.stubs(:doSomething)
    @protected_mock.stubs(:doSomething)
    @package_mock.stubs(:doSomething)
  end
  
  describe "when doing it all" do
    def when_doing_it_all
      yield
      @do_stuff.do_it_all
    end
    
    it "should do something with the private HasPublicMethod" do
      when_doing_it_all { @private_mock.expects(:doSomething) }
    end
    
    it "should do something with the private HasPublicMethod" do
      when_doing_it_all { @protected_mock.expects(:doSomething) }
    end

    it "should do something with the private HasPublicMethod" do
      when_doing_it_all { @package_mock.expects(:doSomething) }
    end
  end
  
  describe "when doing something sneaky" do
    it "should do something with the private HasPublicMethod" do
      @private_mock.expects(:doSomething)
      @do_stuff.doSomethingSneaky
    end
  end
  
  describe "when doing something sneaky" do
    it "should do something with the protected HasPublicMethod" do
      @protected_mock.expects(:doSomething)
      @do_stuff.doSomethingSomewhatPromiscuous
    end
  end

  describe "when doing something sneaky" do
    it "should do something with the package HasPublicMethod" do
      @package_mock.expects(:doSomething)
      @do_stuff.doSomethingSlightlyPromiscuous
    end
  end  
end    