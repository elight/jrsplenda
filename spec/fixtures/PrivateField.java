package fixtures;

public class PrivateField {
  private String strField = "42";
  private final String finalField = "foo";
  
  public String getStrField() {
    return strField;
  }
}