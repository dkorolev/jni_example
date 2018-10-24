#include <jni.h>

#include <string>

#include "Blah.h"

inline std::string ToStdString(JNIEnv* java_environment, jstring java_string) {
  std::string result;
  char const* utfBuffer = java_environment->GetStringUTFChars(java_string, 0); 
  if (utfBuffer) {
    result = utfBuffer;
    java_environment->ReleaseStringUTFChars(java_string, utfBuffer);
  }
  return result;
}

JNIEXPORT jstring JNICALL Java_Blah_doSomethingWithString(JNIEnv *java_environment, jobject, jstring arg) {
  std::string s = ToStdString(java_environment, arg);
  return java_environment->NewStringUTF((std::string("Testing with `") + s + "`: passed.").c_str());
}
