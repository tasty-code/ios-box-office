
import Foundation

final class RequestBuilder: RequestBuilderProtocol {
    
    private var request: URLRequest?
        
    // URL 설정
    func setURL(_ url: URL) -> Self {
        self.request = URLRequest(url: url)
        return self
    }
    
    // HTTP 메소드 설정
    func setHTTPMethod(_ method: HTTPMethodType) -> Self {
        request?.httpMethod = method.rawValue
        return self
    }
    
    // 헤더 필드 추가
    func addHeaderField(key: String, value: String) -> Self {
        request?.setValue(value, forHTTPHeaderField: key)
        return self
    }
    
    func build() -> URLRequest? {
        guard let request else { return nil }
        return request
    }
}
