require File.dirname(__FILE__) + '/spec_helper.rb'

describe "A mock helper" do
  include JRSplenda::MockHelper
  
  it "should create a mock of a Java class when give a Java class name when the Java class has not been imported" do
    splenda_mock('fixtures.PrivateField').should be_a_kind_of(PrivateField)
  end

  it "should create a mock of a Java class when give a Java class name when the Java class has been imported" do
    splenda_mock('fixtures.PrivateField').should be_a_kind_of(PrivateField)
  end
  
  it "should create a mock of a Java class when given a Ruby class wrapping the Java class" do
    import 'fixtures.PrivateField'
    splenda_mock(PrivateField).should be_a_kind_of(PrivateField)
  end
end