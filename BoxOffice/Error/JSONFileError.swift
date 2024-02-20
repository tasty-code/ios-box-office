import Foundation

enum JSONFileError: Error {
    case josonDecoderError (fileName: String)
    case pathError (fileName: String)
    case utf8Error (fileName: String)
}

extension JSONFileError: LocalizedError {
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


