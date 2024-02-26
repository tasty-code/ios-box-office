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
    var redirectRange: Range<Int> { get }
    var clientErrorRange: Range<Int> { get }
    var serverErrorRange: Range<Int> { get }
}

extension StatusCodeProtocol {
    var information: Range<Int> { (100..<200) }
    var success: Range<Int> { 200..<300 }
    var redirectRange: Range<Int> { 300..<400 }
    var clientErrorRange: Range<Int> { 400..<500 }
    var serverErrorRange: Range<Int> { 500..<600 }
}

