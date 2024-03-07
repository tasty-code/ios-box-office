import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resoure = NSDictionary(contentsOfFile: file) else {
            fatalError("Info.plist 파일을 찾을 수 없습니다.")
        }
        guard let key = resoure["API_KEY"] as? String else {
            fatalError("API 키를 찾을 수 없습니다.")
        }
        return key
    }
}
