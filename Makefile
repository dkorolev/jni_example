.PHONY: all run clean

all: run

JAVA_INC=/usr/lib/jvm/default-java/include

out:
	mkdir -p out

Blah.class: Blah.java
	javac Blah.java

Blah.h: Blah.java
	javah Blah

out/libblah.so: out BlahImpl.cpp Blah.h
	g++ -std=c++11 -shared -fPIC -I${JAVA_INC} -I${JAVA_INC}/linux BlahImpl.cpp -o $@

run: Blah.class out/libblah.so
	java -Djava.library.path=out Blah

clean:
	rm -r Blah.class
	rm -rf out/
