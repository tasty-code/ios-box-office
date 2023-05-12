//
//  ViewModelType.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/04.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input? { get }
    var output: Output { get }
}
