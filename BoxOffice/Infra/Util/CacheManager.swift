import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
