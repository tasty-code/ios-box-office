
import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    
    private let requestProvider: RequestProvidable
    private let sessionProvider: SessionProvidable
    private let decoder: URLDecodeProtocol
    
    init(request: RequestProvidable, session: SessionProvidable, decoder: URLDecodeProtocol) {
        self.requestProvider = request
        self.sessionProvider = session
        self.decoder = decoder
    }

    func getBoxofficeData() async -> Result<BoxOfficeDataDTO, NetworkError> {
        guard let request = requestProvider.makeURLRequest() else { return .failure(.urlError) }
        let result = await sessionProvider.loadAPIRequest(using: request)
    
        switch result {
        case .success(let networkResponse):
            guard let data = networkResponse.data else { return .failure(.notFound)}
            let decodeResult: Result<BoxOfficeDataDTO, NetworkError> = decoder.decode(data)
            return decodeResult
        case .failure(let networkError):
            return .failure(networkError)
        }
    }


    func getMovieList() async {
        print("")
    }
    
    func getMovieInfo() async {
        print("")
    }
}


