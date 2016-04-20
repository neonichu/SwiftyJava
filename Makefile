JVM_LIBRARY_PATH=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/jre/lib/server

.PHONY: all clean

all:
	swift build -Xlinker -L$(JVM_LIBRARY_PATH) \
		-Xlinker -rpath -Xlinker $(JVM_LIBRARY_PATH)
	./.build/debug/hello

clean:
	swift build --clean
