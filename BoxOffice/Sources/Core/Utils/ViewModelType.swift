//
//  ViewModelType.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/04.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
