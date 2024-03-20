
import Foundation

protocol APIKey {
    var APIKey: String { get }
}

struct DebugEnvironment: APIKey {
    var APIKey: String
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file '\(resourceName)' plist")
        }
        
        self.APIKey = plist.object(forKey: "API_KEY") as? String ?? ""
    }
}


