
import Foundation

protocol RequestProvidable {
    var baseURL: BaseURLType { get }
    func makeURLRequest() -> URLRequest?
}

extension RequestProvidable {
    var baseURL: BaseURLType { .kobis }
}
