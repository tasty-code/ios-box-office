//
//  ViewModelType.swift
//  BoxOffice
//
//  Created by EUNJU on 3/8/24.
//

import Foundation

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
