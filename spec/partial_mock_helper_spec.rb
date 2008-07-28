require File.dirname(__FILE__) + '/spec_helper.rb'

describe "A mock helper" do
  include JRSplenda::MockHelper
  
  it "should create a partial mock of a Java class when give a Java class name when the Java class has not been imported" do
    pending
    splenda_partial_mock('fixtures.PrivateField').should be_a_kind_of(PrivateField)
  end

  it "should create a partial mock of a Java class when give a Java class name when the Java class has been imported" do
    pending
    splenda_partial_mock('fixtures.PrivateField').should be_a_kind_of(PrivateField)
  end
  
  it "should create a partial mock of a Java class when given a Ruby class wrapping the Java class" do
    pending
    import 'fixtures.PrivateField'
    splenda_partial_mock(PrivateField).should be_a_kind_of(PrivateField)
  end

  it "should not blankslate the partially mocked object" do
    pending
    mock = splenda_partial_mock('fixtures.PrivateInstanceMethod')
    mock.should respond_to(:thePrivateMethod)
    mock.thePrivateMethod.should == "42"
  end

  it "should replace a method with an expectation when the #expects method is used" do
    pending
    mock = splenda_partial_mock('fixtures.PrivateInstanceMethod')
    mock.expects(:thePrivateMethod).and_returns("43")
    mock.thePrivateMethod.should == "43"
  end
    
  describe "when creating a partial mock object" do
    it "should optionally not overwrite existing member variables" do
      pending
      splenda_partial_mock_attr('fixtures.PrivateField')
      p1 = @private_field
      splenda_partial_mock_attr('fixtures.PrivateField', :preserve_existing_attr => true)
      p1.should equal(@private_field)
    end
  end
end