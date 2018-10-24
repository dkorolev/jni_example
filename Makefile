.PHONY: all run clean

all: run

JAVA_INC=/usr/lib/jvm/default-java/include

Blah.class: Blah.java
	javac Blah.java

Blah.h: Blah.java
	javah Blah

libblah.so: BlahImpl.cpp Blah.h
	g++ -std=c++11 -shared -fPIC -I${JAVA_INC} -I${JAVA_INC}/linux BlahImpl.cpp -o libblah.so

run: Blah.class libblah.so
	java -Djava.library.path=. Blah

clean:
	rm -f Blah.class libblah.so
