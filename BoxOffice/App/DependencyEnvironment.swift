
import UIKit

enum ViewControllerType {
    case boxOffice
}

final class DependencyEnvironment {
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    private lazy var decodeProvider: DecoderProtocol = JsonDecoder(jsonDecoder: jsonDecoder)

    private var sessionProvider: SessionProvidable = SessionProvider()

    private lazy var movieRepository: MovieRepositoryProtocol = MovieRepository(sessionProvider: sessionProvider, decoder: decodeProvider)
    
    private lazy var mapper: Mappaple = Mapper(movieRepository: movieRepository)
    
    private lazy var boxOfficeUseCase: BoxOfficeUseCaseProtocol = BoxOfficeUseCase(mapper: mapper)
}

extension DependencyEnvironment: ViewControllerFactoryProtocol {
    func makeViewController(for type: ViewControllerType) -> UIViewController {
        switch type {
        case .boxOffice:
            return BoxOfficeViewController(boxOfficeUseCase: boxOfficeUseCase)
        }
    }
}
