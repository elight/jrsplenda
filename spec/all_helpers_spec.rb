require File.dirname(__FILE__) + '/spec_helper.rb'

include JRSplenda

describe "The AllHelpers module" do
  it "should mixin the MockHelper" do
    AllHelpers.ancestors.include? MockHelper
  end

  it "should mixin the FieldHelper" do
    AllHelpers.ancestors.include? FieldHelper
  end

  it "should mixin the MethodHelper" do
    AllHelpers.ancestors.include? MethodHelper
  end
  
  describe "when mixed into an object" do
    include AllHelpers
    
    it "should provide a way to wrap all fields and methods in a single call" do
      import 'fixtures.PrivateField'
      field = PrivateField.new
      wrap_java_object field
      field.str_field.should == "42"
      
      import 'fixtures.PrivateInstanceMethod'
      method = PrivateInstanceMethod.new
      wrap_java_object method
      method.the_private_method.should == "42"
    end
  end
end

  