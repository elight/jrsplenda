package fixtures;

public class DelegateToPublicInstanceMethod
{
  public PublicInstanceMethod publicInstanceMethod;
  
  public String delegateDoSomething() {
    return publicInstanceMethod.thePublicMethod1();
  }
}