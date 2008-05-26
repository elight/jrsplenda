package fixtures;

public class PackageField {
  String strField = "42";
  final String finalField = "foo";  
  static String staticField = "42";
  static final String staticFinalField = "42";
  
  public String getStrField() {
    return strField;
  }
}