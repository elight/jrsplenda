package fake;

public class DoStuff {
  private HasPublicMethod privateHasPublicMethod = new HasPublicMethod();
  protected HasPublicMethod protectedHasPublicMethod = new HasPublicMethod();
  HasPublicMethod packageHasPublicMethod = new HasPublicMethod();
  public HasPublicMethod publicHasPublicMethod = new HasPublicMethod();

  public void doItAll() {
    doSomethingPrivate();
    doSomethingPackageScope();
    doSomethingProtected();
    doSomethingPublic();
  }
  
  void doSomethingPackageScope() {
    packageHasPublicMethod.doSomething();
  }
  
  protected void doSomethingProtected() {
    protectedHasPublicMethod.doSomething();
  }
  
  private void doSomethingPrivate() {
    privateHasPublicMethod.doSomething();
  }
  
  public void doSomethingPublic() {
    publicHasPublicMethod.doSomething();
  }
}