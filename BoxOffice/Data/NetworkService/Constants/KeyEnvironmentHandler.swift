
import Foundation

protocol APIKeyable {
    var API_KEY: String { get }
}

class BaseEnvironment {
    
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file '\(resourceName)' plist")
        }
        self.dict = plist
    }
}

final class DebugEnvironment: BaseEnvironment, APIKeyable {
    
    var API_KEY: String {
        dict.object(forKey: "API_KEY") as? String ?? ""
    }

    init() {
        super.init(resourceName: "DEBUG-Keys")
    }
}

