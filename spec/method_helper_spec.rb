require File.dirname(__FILE__) + '/spec_helper.rb'

include JRSplenda

describe "A method helper" do
  describe "when given a Ruby object wrapping a Java class" do
    it "should provide the ability to invoke protected Java class methods"
    it "should provide the ability to invoke private Java class methods"
    it "should provide the ability to invoke public Java class methods"    
    it "should error when given a non-existent method name"
  end

  describe "when given a Ruby object wrapping a Java object" do
    it "should provide the ability to invoke protected Java instance methods"
    it "should provide the ability to invoke private Java instance methods"
    it "should error when given a non-existent method name"
  end
end
