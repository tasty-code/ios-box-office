//
//  RangeProtocol.swift
//  BoxOffice
//
//  Created by Roh on 2/24/24.
//

import Foundation

protocol StatusCodeProtocol {
    var information: Range<Int> { get }
    var success: Range<Int> { get }
    var redirect: Range<Int> { get }
    var clientError: Range<Int> { get }
    var serverError: Range<Int> { get }
}

extension StatusCodeProtocol {
    var information: Range<Int> { (100..<200) }
    var success: Range<Int> { 200..<300 }
    var redirect: Range<Int> { 300..<400 }
    var clientError: Range<Int> { 400..<500 }
    var serverError: Range<Int> { 500..<600 }
}

