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
      @f.str_field = "42" 
    end
    
    it "should provide an attr get method" do
      @f.str_field.should == "42"
    end    
    
    it "should not provide an attr set method if the field is final" do
      lambda { @f.final_field = "42" }.should raise_error
    end
  end
  
  describe "for a protected field" do
    before(:each) do
      @f = ProtectedField.new
      wrap_java_fields @f
    end
        
    it "should provide an attr set method" do
      @f.str_field = "42"
    end
    
    it "should provide an attr get method" do
      @f.str_field.should == "42"
    end    
    
    it "should not provide an attr set method if the field is final" do
      lambda { @f.final_field = "42" }.should raise_error
    end
  end
  
  describe "for a package-scoped field" do
    before(:each) do
      @f = PackageField.new
      wrap_java_fields @f      
    end
    
    it "should provide an attr set method" do
      @f.str_field = "42"
    end

    it "should provide an attr get method" do
      @f.str_field.should == "42"
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { @f.final_field = "42" }.should raise_error
    end
  end
  
  describe "for a static private field" do
    before(:all) do
      wrap_java_fields PrivateField
    end
    
    it "should provide an attr set method" do
      PrivateField.static_field = "42"
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { PrivateField.static_final_field = "42" }.should raise_error
    end
    
    it "should provide an attr get method"
  end
  
  describe "for a static protected field" do
    before(:all) do
      wrap_java_fields ProtectedField
    end
        
    it "should provide an attr set method" do
      ProtectedField.static_field = "42"
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { ProtectedField.static_final_field = "42" }.should raise_error
    end
    
    it "should provide an attr get method"    
  end
  
  describe "for a static package-scoped field" do
    before(:all) do
      wrap_java_fields PackageField
    end
    
    it "should provide an attr set method" do
      PackageField.static_field = "42"
    end
    
    it "should not provide an attr set method if the field is final" do
      lambda { PackageField.static_final_field = "42" }.should raise_error
    end
    
    it "should provide an attr get method"
  end  
end