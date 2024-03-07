
import Foundation

final class BaseURLManager: BaseURLProvidable, BaseURLConfigurable {
    
    static let shared = BaseURLManager()
    
    private init() {}
    
    private var baseURLMap: [BaseURLType: URL] = [:]
    
    func get(for type: BaseURLType) -> URL? {
        baseURLMap[type]
    }
    
    func configure(_ url: URL, for type: BaseURLType) {
        baseURLMap[type] = url
    }
}


