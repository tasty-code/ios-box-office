
import Foundation

protocol RequestProvidable {
    var baseURL: BaseURLType { get }
    func makeURLRequest(for boxOfficeType: URLProvider) -> URLRequest?
}

extension RequestProvidable {
    var baseURL: BaseURLType { .kobis }
}
