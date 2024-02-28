import Foundation

protocol Observable {
    associatedtype ValueType
    var valueChanged: ((ValueType) -> Void)? { get set }
    func notifyObserver()
}

class ObservableValue<T>: Observable {
    typealias ValueType = T
    
    var value: T {
        didSet {
            notifyObserver()
        }
    }
    
    var valueChanged: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func notifyObserver() {
        valueChanged?(value)
    }
}
