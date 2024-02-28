import Foundation

class MoviesListViewModel {
    var movies: ObservableValue<[MovieBoxOffice]> = ObservableValue([])
    
    func fetchData(completion: @escaping (Result<[MovieBoxOffice], Error>) -> Void) {
        let boxOfficeAPI = APIConfig<BoxOfficeResponseDTO>.boxOfficeAPI()
        let networkService = DefaultNetworkService()
        _ = networkService.request(apiConfig: boxOfficeAPI) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let boxOfficeResponse = try JSONDecoder().decode(BoxOfficeResponseDTO.self, from: data)
                        let movies = boxOfficeResponse.boxOfficeResult.movieBoxOfficeList.map { MovieBoxOffice(from: $0) }
                        self.movies.value = movies
                        completion(.success(movies))
                    } catch {
                        print("decoding error: \(error)")
                    }
                }
            case .failure(let error):
                print("Network error: \(error)")
            }
        }
    }
}
