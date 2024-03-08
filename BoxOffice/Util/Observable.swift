//
//  Observable.swift
//  BoxOffice
//
//  Created by EUNJU on 3/8/24.
//

import Foundation

final class Observable<T> {

    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            self.listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(_ closure: @escaping (T) -> Void) {
        closure(value)
        self.listener = closure
    }
}
