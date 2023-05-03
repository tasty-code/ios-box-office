//
//  Observable.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/03.
//

import Foundation

@propertyWrapper
final class Observable<Value> {
    
    typealias Listener = (Value) -> Void
    
    // MARK: - Properties
    
    var listener: Listener?
    
    var wrappedValue: Value {
        didSet {
            listener?(wrappedValue)
        }
    }
    
    var projectedValue: Observable<Value> {
        self
    }
    
    // MARK: - Initialization
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    // MARK: - Public Methods
    
    func bind(isFireAtBind: Bool = true, listener: Listener?) {
        self.listener = listener
        if isFireAtBind {
            listener?(wrappedValue)
        }
    }
}
