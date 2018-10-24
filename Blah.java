import java.util.Scanner;

public class Blah {
  static {
    System.loadLibrary("blah");
  }

  private native String doSomethingWithString(String string);

  public static void main(String[] args) {
    Blah blah = new Blah();
    Scanner input = new Scanner(System.in);
    System.out.println("Type some strings, and we'll route them through a JNI library. Ctrl+D to quit, of course.");
    while (input.hasNextLine()) {
      System.out.println(blah.doSomethingWithString(input.nextLine()));
    }
  }
}
