require File.dirname(__FILE__) + '/spec_helper.rb'

import 'fixtures.PrivateField'
import 'fixtures.ProtectedField'
import 'fixtures.PackageField'

describe "A field helper" do
  include JRSplenda::FieldHelper
  
  describe "for a private field" do
    before(:each) do
      @f = PrivateField.new
      wrap_java_fields @f
    end
    
    it "should provide an attr set method" do
      lambda { @f.str_field = "42" }.should_not raise_error
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { @f.final_field == "42" }.should raise_error
    end
  end
  
  describe "for a protected field" do
    before(:each) do
      @f = ProtectedField.new
      wrap_java_fields @f
    end
        
    it "should provide an attr set method" do
      lambda { @f.str_field = "42" }.should_not raise_error
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { @f.final_field == "42" }.should raise_error
    end
  end
  
  describe "for a package-scoped field" do
    before(:each) do
      @f = PackageField.new
      wrap_java_fields @f      
    end
    
    it "should provide an attr set method" do
      lambda { @f.str_field = "42" }.should_not raise_error
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { @f.final_field == "42" }.should raise_error
    end
  end
end