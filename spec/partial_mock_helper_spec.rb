require File.dirname(__FILE__) + '/spec_helper.rb'

describe "A mock helper" do
  include JRSplenda::MockHelper
  
  it "should create a partial mock of a Java class when given a Java class name when the Java class has not been imported" do
    splenda_partial_mock('fixtures.PrivateField').should be_a_kind_of(PrivateField)
  end

  it "should create a partial mock of a Java class when given a Java class name when the Java class has been imported" do
    splenda_partial_mock('fixtures.PrivateField').should be_a_kind_of(PrivateField)
  end

  it "should create a partial mock of a Java class when given a Ruby class wrapping the Java class" do
    splenda_partial_mock(PrivateField).should be_a_kind_of(PrivateField)
  end

  it "should not blankslate public methods on a partially mocked object" do
    mock = splenda_partial_mock('fixtures.PublicInstanceMethod')
    mock.should respond_to(:thePublicMethod1)
    mock.thePublicMethod1.should == "42"
  end

  it "should not blankslate jrsplenda exposed methods on a partially mocked object" do
    mock = splenda_partial_mock('fixtures.PrivateInstanceMethod')
    mock.should respond_to(:thePrivateMethod)
    mock.thePrivateMethod.should == "42"
  end


  it "should allow partial mocks to replace a jrsplenda exposed method with an expectation when the #expects method is used" do
    mock = splenda_partial_mock('fixtures.PrivateInstanceMethod')
    mock.expects(:thePrivateMethod).returns("43")
    mock.thePrivateMethod.should == "43"
  end

  it "should allow partial mocks to replace a public method with an expectation when the #expects method is used" do
    mock = splenda_partial_mock('fixtures.PublicInstanceMethod')
    mock.expects(:thePublicMethod1).returns("43")
    mock.thePublicMethod1.should == "43"
    mock.thePublicMethod2.should == "1764"
  end
end