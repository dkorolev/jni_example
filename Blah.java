public class Blah {
  static {
    System.loadLibrary("blah");
  }

  private native String doSomethingWithString(String string);

  public static void main(String[] args) {
    System.out.println((new Blah()).doSomethingWithString("test"));
  }
}
