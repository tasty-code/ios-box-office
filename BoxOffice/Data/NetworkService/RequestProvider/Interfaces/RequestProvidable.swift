
import Foundation

protocol RequestProvidable {
    func makeURLRequest(for boxOfficeType: URLProvider) -> URLRequest?
}
