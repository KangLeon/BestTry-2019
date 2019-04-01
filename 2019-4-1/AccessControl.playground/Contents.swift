import UIKit

public class SomePublicClass {                          // explicitly public class
    public var somePublicProperty = 0               // explicitly public class member
    var someInternalProperty = 0                      // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}   // explicitly file-private class member
    private func somePrivateMethod() {}           // explicitly private class member
}

class SomeInternalClass {                                 // implicitly internal class
    var someInternalProperty = 0                      // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}   // explicitly file-private class member
    private func somePrivateMethod() {}            // explicitly private class member
}

fileprivate class SomeFilePrivateClass {            // explicitly file-private class
    func someFilePrivateMethod() {}                 // implicitly file-private class member
    private func somePrivateMethod() {}           // explicitly private class member
}

private class SomePrivateClass {                     // explicitly private class
    func somePrivateMethod() {}                     // implicitly private class member
}

//函数类型的访问级别由函数成员类型和返回类型中的最严格访问级别决定。如果函数的计算访问级别与上下文环境默认级别不匹配，你必须在函数定义时显式指出。
