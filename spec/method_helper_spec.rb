require File.dirname(__FILE__) + '/spec_helper.rb'

import 'fixtures.PrivateInstanceMethod'
import 'fixtures.PrivateStaticMethod'
import 'fixtures.ProtectedInstanceMethod'
import 'fixtures.ProtectedStaticMethod'
import 'fixtures.PackageInstanceMethod'
import 'fixtures.PackageStaticMethod'

describe "A method helper" do
  include JRSplenda::MethodHelper
  
  it "should provide the ability to invoke private Java class methods" do
    wrap_java_methods PrivateStaticMethod
    lambda { PrivateStaticMethod.thePrivateMethod.should == "42" }.should_not raise_error
  end
  
  it "should provide the ability to invoke protected Java class methods" do
    wrap_java_methods ProtectedStaticMethod
    lambda { ProtectedStaticMethod.theProtectedMethod.should == "42" }.should_not raise_error
  end
  
  it "should provide the ability to invoke package scope Java class methods" do
    wrap_java_methods PackageStaticMethod
    lambda { PackageStaticMethod.thePackageScopeMethod.should == "42"}.should_not raise_error
  end
  
  it "should provide the ability to invoke private Java instance methods" do
    o = PrivateInstanceMethod.new
    wrap_java_methods o
    lambda { o.thePrivateMethod.should == "42" }.should_not raise_error
  end
  
  it "should provide the ability to invoke protected Java instance methods" do
    o = ProtectedInstanceMethod.new
    wrap_java_methods o
    lambda { o.theProtectedMethod.should == "42" }.should_not raise_error
  end
  
  it "should provide the ability to invoke package scope Java instance methods" do
    o = PackageInstanceMethod.new
    wrap_java_methods o
    lambda { o.thePackageScopeMethod.should == "42" }.should_not raise_error
  end
end
