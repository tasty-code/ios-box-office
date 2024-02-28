
import Foundation

protocol RequestProvidable {
    func makeURLRequest(for boxOfficeType: URLProvidable) -> URLRequest?
}
