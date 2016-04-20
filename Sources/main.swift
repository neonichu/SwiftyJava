import CJavaVM

func create_vm(vmPtr: UnsafeMutablePointer<UnsafeMutablePointer<JavaVM>>) -> UnsafeMutablePointer<JNIEnv> {
  var args = JavaVMInitArgs()
  args.ignoreUnrecognized = 0
  args.version = JNI_VERSION_1_6

  args.nOptions = 1
  var options = JavaVMOption()

  var env: UnsafeMutablePointer<JNIEnv> = nil
  var retval: jint = 0

  withUnsafeMutablePointers(&options, &env) { optionsPtr, envPtr in
    args.options = optionsPtr

    "-Djava.class.path=./".withCString {
        let str = $0
        options.optionString = UnsafeMutablePointer<Int8>(str)
        let ptr = UnsafeMutablePointer<UnsafeMutablePointer<Void>>(envPtr)
        retval = JNI_CreateJavaVM(vmPtr, ptr, &args)
    }
  }
   
  if retval < 0 || env == nil {
    print("Unable to launch JVM: \(retval)")
  } else {
    print("Launched JVM!")
  }

  return env
}

var vm: UnsafeMutablePointer<JavaVM> = nil
let env = create_vm(&vm)
