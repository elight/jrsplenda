## This normally goes in a spec_helper.rb

require File.join(File.dirname(__FILE__), "..", "..", "lib", "jrsplenda")
require File.join(File.dirname(__FILE__), "..", "..", "build", "jrsplenda-sample-fixtures.jar")

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

## 

import 'fake.DoStuff'    

describe 'Doing stuff' do
  include JRSplenda::AllHelpers
  
  before(:each) do
    @private_mock = splenda_partial_mock 'fake.HasPublicMethod'
    @protected_mock = splenda_mock 'fake.HasPublicMethod'
    @package_mock = splenda_mock 'fake.HasPublicMethod'
    @public_mock = splenda_partial_mock 'fake.HasPublicMethod'

    @do_stuff = DoStuff.new
    wrap_java_object @do_stuff
    @do_stuff.private_has_public_method = @private_mock
    @do_stuff.protected_has_public_method = @protected_mock
    @do_stuff.package_has_public_method = @package_mock
    @do_stuff.public_has_public_method = @public_mock
  end
  
  describe "when doing it all" do
    before(:each) do
    # @private_mock.stubs(:doSomething)
      @protected_mock.stubs(:doSomething)
      @package_mock.stubs(:doSomething)
    # @public_mock.stubs(:doSomething)
    end
    
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
    
    it "should do something with the public hasPublicMethod" do
      when_doing_it_all { @public_mock.expects(:doSomething) }
    end
  end
  
  it "should do something with the private HasPublicMethod" do
    @private_mock.expects(:doSomething)
    @do_stuff.doSomethingPrivate
  end

  it "should do something with the protected HasPublicMethod" do
    @protected_mock.expects(:doSomething)
    @do_stuff.doSomethingProtected
  end


  it "should do something with the package HasPublicMethod" do
    @package_mock.expects(:doSomething)
    @do_stuff.doSomethingPackageScope
  end
  
  it "should do something with the public HasPublicMethod" do
    @public_mock.expects(:doSomething)
    @do_stuff.doSomethingPublic
  end
end    