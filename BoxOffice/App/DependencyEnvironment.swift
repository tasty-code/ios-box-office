
import UIKit

enum ViewControllerType {
    case boxOffice
    //case 이후뷰컨들
}

final class DependencyEnvironment {
    /// 디코더 설정 셋팅 예시
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()

    private lazy var decodeProvider: DecoderProtocol = JsonDecoder(jsonDecoder: jsonDecoder)

    private var sessionProvider: SessionProvidable = SessionProvider()

    private lazy var movieRepository: MovieRepositoryProtocol = MovieRepository(sessionProvider: sessionProvider, decoder: decodeProvider)
    
    private lazy var boxOfficeUseCase: BoxOfficeUseCaseProtocol = BoxOfficeUseCase(moviesRepository: movieRepository)
}

extension DependencyEnvironment: ViewControllerFactoryProtocol {
    func makeViewController(for type: ViewControllerType) -> UIViewController {
        switch type {
        case .boxOffice:
            return BoxOfficeViewController(boxOfficeUseCase: boxOfficeUseCase)
        }
    }
}
