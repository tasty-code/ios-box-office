
import Foundation

final class DependencyEnvironment {
    
    static let shared = DependencyEnvironment()
    
    private init() {}
    
    private(set) lazy var requestProvider: RequestProvidable = {
        RequestProvider(httpMethod: HTTPMethodType.get)
    }()

    private(set) lazy var sessionProvider: SessionProvidable = {
        SessionProvider()
    }()
    
    private(set) lazy var decodeProvider: URLDecodeProtocol = {
        URLDecoder()
    }()
    
    private(set) lazy var movieRepository: MovieRepositoryProtocol = {
        MovieRepository(request: requestProvider, session: sessionProvider, decoder: decodeProvider)
    }()
    
    private(set) lazy var boxOfficeUseCase: BoxOfficeUseCaseProtocol = {
        BoxOfficeUseCase(moviesRepository: movieRepository)
    }()
    
    func makeBoxOfficeCollectionViewController() -> BoxOfficeCollectionViewController {
        return BoxOfficeCollectionViewController(usecase: boxOfficeUseCase)
    }
}
