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

  it "should receive calls delegated by Java objects" do
    import 'fixtures.DelegateToPublicInstanceMethod'
    delegatingObj = DelegateToPublicInstanceMethod.new
    mock = splenda_mock('fixtures.PublicInstanceMethod')
    mock.expects(:thePublicMethod1).returns("55")
    delegatingObj.publicInstanceMethod = mock
    delegatingObj.delegateDoSomething().should == "55"
  end
    
  describe "when creating a mock object" do
    it "should optionally store the created mock in a Ruby member variable by convention" do
      splenda_mock_attr('fixtures.PrivateField')
      @private_field.should_not be_nil
    end
    
    it "should optionally store the created mock in a Ruby member variable specified by the caller" do
      splenda_mock_attr('fixtures.PrivateField', :store_in => :another_field)
      @another_field.should_not be_nil
    end
    
    it "should optionally not overwrite existing member variables" do
      splenda_mock_attr('fixtures.PrivateField')
      p1 = @private_field
      splenda_mock_attr('fixtures.PrivateField', :preserve_existing_attr => true)
      p1.should equal(@private_field)
    end
  end
end