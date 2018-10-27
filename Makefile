.PHONY: all run clean

all: run

ifeq ($(shell uname -s),Darwin)
  OS_INCLUDE_DIR=darwin
  LIBRARY_EXTENSION=dylib
  JAVA_INC=$(shell /usr/libexec/java_home)/include
else
  OS_INCLUDE_DIR=linux
  LIBRARY_EXTENSION=so
  JAVA_INC=/usr/lib/jvm/default-java/include
endif

out:
	mkdir -p out

Blah.class: Blah.java
	javac Blah.java

Blah.h: Blah.java out
	rm -f $@ && javac -h out $< && cp out/$@ .

out/libblah.${LIBRARY_EXTENSION}: out BlahImpl.cpp Blah.h
	g++ -std=c++11 -shared -fPIC -I${JAVA_INC} -I${JAVA_INC}/${OS_INCLUDE_DIR} BlahImpl.cpp -o $@

run: Blah.class out/libblah.${LIBRARY_EXTENSION}
	echo "foo bar baz" | java -Djava.library.path=out Blah

clean:
	rm -f Blah.h Blah.class
	rm -rf out/
