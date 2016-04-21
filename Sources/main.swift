import CJavaVM

extension jvalue: CustomStringConvertible {
    public var description: String {
        return "\(self.i)"
    }
}

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

    "-Djava.class.path=./hello_world".withCString {
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
let jni = env.pointee.pointee

let hello_class = jni.FindClass(env, "helloWorld")

let main_method = jni.GetStaticMethodID(env, hello_class, "main", "([Ljava/lang/String;)V")
jni.CallStaticVoidMethodA(env, hello_class, main_method, [])

let square_method = jni.GetStaticMethodID(env, hello_class, "square", "(I)I")
let number = jvalue(i: 20)
let square_result = jni.CallStaticIntMethodA(env, hello_class, square_method, [number])
print("\(number) square is \(square_result)")

let power_method = jni.GetStaticMethodID(env, hello_class, "power", "(II)I")
let exponent = jvalue(i: 3)
let power_result = jni.CallStaticIntMethodA(env, hello_class, power_method, [number, exponent])
print("\(number) raised to the \(exponent) power is \(power_result)")
