//
//  Observable.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/02.
//

import Foundation

@propertyWrapper
struct Observable<Value> {
    
    // MARK: - Store
    
    private final class Store<Value> {
        var listeners: [(Value) -> Void] = []
    }
    
    // MARK: - Properties
    
    private let store = Store<Value>()
    
    var projectedValue: Observable<Value> { self }
    
    var wrappedValue: Value {
        didSet {
            store.listeners.forEach { listener in
                listener(wrappedValue)
            }
        }
    }
    
    // MARK: - Public Methods
    
    func bind(doesFireAtBind: Bool = false, listener: @escaping (Value) -> Void) {
        store.listeners.append(listener)
        if doesFireAtBind {
            listener(wrappedValue)
        }
    }
    
    func dispose() {
        store.listeners.removeAll()
    }
    
    static func dispose(_ observables: [Observable]) {
        observables.forEach {
            $0.dispose()
        }
    }
}
