JVM_HEADER_PATH=/System/Library/Frameworks/JavaVM.framework/Versions/A/Headers
JVM_LIBRARY_PATH=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/jre/lib/server

.PHONY: all clean run

all: run

helloWorld.class: helloWorld.java
	javac helloWorld.java

hello_world: hello_world.c
	$(CC) -o hello_world \
	-Wno-deprecated-declarations \
	-L$(JVM_LIBRARY_PATH) \
	-ljvm \
	-rpath $(JVM_LIBRARY_PATH) \
	-I$(JVM_HEADER_PATH) \
	hello_world.c

run: helloWorld.class hello_world
	./hello_world

clean:
	rm -f helloWorld.class hello_world
