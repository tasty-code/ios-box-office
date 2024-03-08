
import Foundation


/// 참고: https://medium.com/@vyacheslavansimov/swift-utilities-thread-safe-property-5498afc2eb53
@propertyWrapper
struct SynchronizedLock<Value> {
    private var value: Value
    private var lock = NSLock()

    var wrappedValue: Value {
        get { lock.synchronized { value } }
        set { lock.synchronized { value = newValue } }
    }

    init(wrappedValue value: Value) {
        self.value = value
    }
}

private extension NSLock {

    func synchronized<T>(_ block: () -> T) -> T {
        lock()
        defer { unlock() }
        return block()
    }
}
