import Foundation

typealias HTTPInteractable =  Responsible & Requestable

protocol Responsible {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
