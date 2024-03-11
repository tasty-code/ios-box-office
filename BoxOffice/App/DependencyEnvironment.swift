
import Foundation

final class DependencyEnvironment {

    /// 디코더 설정 셋팅 예시
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    static let shared = DependencyEnvironment()
    
    private init() {}
    
    private(set) lazy var sessionProvider: SessionProvidable = SessionProvider()
    
    private(set) lazy var decodeProvider: JsonDecodeProtocol = JsonDecoder(jsonDecoder: jsonDecoder)

    
    private(set) lazy var networkManager: Networkmanagable = {
        NetworkManager(sessionProvider: sessionProvider, decoder: decodeProvider)
    }()

    private(set) lazy var movieRepository: MovieRepositoryProtocol = {
        MovieRepository(networkManager: networkManager)
    }()
    
    private(set) lazy var boxOfficeUseCase: BoxOfficeUseCaseProtocol = BoxOfficeUseCase(moviesRepository: movieRepository)
    
    func makeBoxOfficeCollectionViewController() -> BoxOfficeViewController {
        BoxOfficeViewController(boxOfficeUseCase: boxOfficeUseCase)
    }
}
