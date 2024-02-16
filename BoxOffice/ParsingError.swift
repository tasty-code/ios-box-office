//
//  ParsingError.swift
//  BoxOffice
//
//  Created by 권태호 on 15/02/2024.
//

import Foundation

enum ParsingError: Error {
    case josonDecoderError (fileName: String)
    case pathError (fileName: String)
    case utf8Error (fileName: String)
}


extension ParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .josonDecoderError(let fileName):
            return "\(fileName) DecodingError"
        case .pathError(let fileName):
            return "\(fileName) PathError"
        case .utf8Error(let fileName):
            return "\(fileName) utf8Error"
        }
    }
}
