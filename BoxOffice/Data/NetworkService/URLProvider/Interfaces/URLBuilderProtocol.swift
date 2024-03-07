
import Foundation

protocol URLBuilderProtocol {
    func setBaseURL(type: BaseURLType) -> Self
    func setPath(_ path: String) -> Self
    func addQueryItem(name: String, value: String?) -> Self
    func setApiKey(apiKey: String) -> Self
    func build() -> URL?
}


