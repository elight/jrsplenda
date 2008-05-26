package fixtures;

public class ProtectedField {
  protected String strField = "42";
  protected final String finalField = "foo";  
  
  public String getStrField() {
    return strField;
  }
}