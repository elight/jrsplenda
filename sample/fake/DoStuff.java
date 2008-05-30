package fake;

public class DoStuff {
  private HasPublicMethod privateHasPublicMethod = new HasPublicMethod();
  protected HasPublicMethod protectedHasPublicMethod = new HasPublicMethod();
  HasPublicMethod packageHasPublicMethod = new HasPublicMethod();

  public void doItAll() {
    privateHasPublicMethod.doSomething();
    protectedHasPublicMethod.doSomething();
    packageHasPublicMethod.doSomething();
  }
  
  void doSomethingSlightlyPromiscuous() {
    packageHasPublicMethod.doSomething();
  }
  
  protected void doSomethingSomewhatPromiscuous() {
    protectedHasPublicMethod.doSomething();
  }
  
  private void doSomethingSneaky() {
    privateHasPublicMethod.doSomething();
  }
}