require File.dirname(__FILE__) + '/spec_helper.rb'

include JRSplenda

describe "A field helper" do
  describe "accessor" do
    it "should provide read access to a java.lang.reflect.Field"
    it "should error when given a non-existent Field name"
  end
  
  describe "mutator" do
    it "should provide write access to a java.lang.reflect.Field"
    it "should error when given a non-existent Field name"
    it "should error when given the name of a 'final' modified Field"
  end
end